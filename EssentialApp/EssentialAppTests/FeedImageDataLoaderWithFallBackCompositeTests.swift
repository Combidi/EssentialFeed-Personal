//
//  Created by Peter Combee on 16/04/2022.
//

import XCTest
import EssentialFeed

final class FeedImageDataLoaderWithFallBackComposite: FeedImageDataLoader {
    private let primary: FeedImageDataLoader
    private let fallback: FeedImageDataLoader
    
    init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    private struct Task: FeedImageDataLoaderTask {
        func cancel() {}
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        primary.loadImageData(from: url) { [weak self] _ in
            _ = self?.fallback.loadImageData(from: url) { _ in }
        }
    }
}

class FeedImageDataLoaderWithFallBackCompositeTests: XCTestCase {
    
    func test_init_doesNotLoadImageData() {
        let (_, primaryLoader, fallbackLoader) = makeSUT()
            
        XCTAssertTrue(primaryLoader.loaderURLs.isEmpty, "Expected no loaded URLs in the primary loader")
        XCTAssertTrue(fallbackLoader.loaderURLs.isEmpty, "Expected no loaded URLs in the fallbackLoader loader")
    }
    
    func test_loadImageData_loadsFromPrimaryLoaderFirst() {
        let url = anyURL()
        let (sut, primaryLoader, fallbackLoader) = makeSUT()

        _ = sut.loadImageData(from: url) { _ in }
        
        XCTAssertEqual(primaryLoader.loaderURLs, [url], "Expected to load URL from primary loader")
        XCTAssertTrue(fallbackLoader.loaderURLs.isEmpty, "Expected no loaded URLs in the fallbackLoader loader")
    }
    
    func test_loadImageData_loadsFromFallbackOnPrimaryLoaderFailure() {
        let url = anyURL()
        let (sut, primaryLoader, fallbackLoader) = makeSUT()

        _ = sut.loadImageData(from: url) { _ in }

        primaryLoader.complete(with: anyNSError())
        
        XCTAssertEqual(primaryLoader.loaderURLs, [url], "Expected to load URL from primary loader")
        XCTAssertEqual(fallbackLoader.loaderURLs, [url], "Expected to load URL from fallbackLoader loader")
    }
    
    func test_cancelLoadImageData_cancelsPrimaryLoaderTask() {
        let url = anyURL()
        let (sut, primaryLoader, fallbackLoader) = makeSUT()

        let task = sut.loadImageData(from: url) { _ in }
        task.cancel()
        
        XCTAssertEqual(primaryLoader.cancelledURLs, [url], "Expected to cancel URL loading from primary loader")
        XCTAssertTrue(fallbackLoader.cancelledURLs.isEmpty, "Expected no cancelled URLs loading in the fallback loader")
    }
    
    // MARK: - Helpers
    private func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: FeedImageDataLoader, primaryLoader: LoaderSpy, fallbackLoader: LoaderSpy) {
        let primaryLoader = LoaderSpy()
        let fallbackLoader = LoaderSpy()
        let sut = FeedImageDataLoaderWithFallBackComposite(primary: primaryLoader, fallback: fallbackLoader)
        trackForMemoryLeaks(primaryLoader, file: file, line: line)
        trackForMemoryLeaks(fallbackLoader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, primaryLoader, fallbackLoader)
    }
    
    private func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
    
    private func anyNSError() -> Error {
        return NSError(domain: "any error", code: 0)
    }
    
    private func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been delocated. Potential memory leak", file: file, line: line)
        }
    }
}

private class LoaderSpy: FeedImageDataLoader {
    private var messages = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
    
    private(set) var cancelledURLs = [URL]()
    
    var loaderURLs: [URL] {
        return messages.map(\.url)
    }
    
    private struct Task: FeedImageDataLoaderTask {
        let callback: () -> Void
                
        func cancel() {
            callback()
        }
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        messages.append((url, completion))
        return Task { [weak self] in
            self?.cancelledURLs.append(url)
        }
    }
    
    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }
}
