//
//  Created by Peter Combee on 16/04/2022.
//

import XCTest
import EssentialFeed

final class FeedImageDataLoaderWithFallBackComposite: FeedImageDataLoader {
    init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {}
    
    private struct Task: FeedImageDataLoaderTask {
        func cancel() {}
    }
    
    func loadImageData(from: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return Task()
    }
}

class FeedImageDataLoaderWithFallBackCompositeTests: XCTestCase {
    
    func test_init_doesNotLoadImageData() {
        let primaryLoader = LoaderSpy()
        let fallbackLoader = LoaderSpy()
        _ = FeedImageDataLoaderWithFallBackComposite(primary: primaryLoader, fallback: fallbackLoader)
    
        XCTAssertTrue(primaryLoader.loaderURLs.isEmpty, "Expected no loaded URLs in the primary loader")
        XCTAssertTrue(fallbackLoader.loaderURLs.isEmpty, "Expected no loaded URLs in the fallbackLoader loader")
    }
}

private class LoaderSpy: FeedImageDataLoader {
    private(set) var loaderURLs = [URL]()
    
    private struct Task: FeedImageDataLoaderTask {
        func cancel() {}
    }
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        loaderURLs.append(url)
        return Task()
    }
}
