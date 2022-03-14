//
//  Created by Peter Combee on 14/03/2022.
//

import Foundation
import EssentialFeed
import EssentialFeediOS

extension FeedUIIntegrationTests {

    class LoaderSpy: FeedLoader, FeedImageDataLoader {
        
        // MARK: - FeedLoader
        
        private var reedRequests = [(FeedLoader.Result) -> Void]()
        
        var loadFeedCallCount: Int {
            return reedRequests.count
        }
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            reedRequests.append(completion)
        }
        
        func completeFeedLoading(with feed: [FeedImage] = [], at index: Int = 0) {
            reedRequests[index](.success(feed))
        }
        
        func completeFeedLoadingWithError(at index: Int) {
            let error = NSError(domain: "an error", code: 0)
            reedRequests[index](.failure(error))
        }
        
        // MARK: - ImageDataLoader
        
        private struct TaskSpy: FeedImageDataLoaderTask {
            let cancelCallback: () -> Void
            func cancel() {
                cancelCallback()
            }
        }
        
        private(set) var imageRequests = [(url: URL, completion: (FeedImageDataLoader.Result) -> Void)]()
        
        var loadedImagesURLs: [URL] {
            imageRequests.map(\.url)
        }
        private(set) var cancelledImagesURLs = [URL]()

        func loadImageData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> FeedImageDataLoaderTask {
            imageRequests.append((url, completion))
            return TaskSpy { [weak self] in self?.cancelledImagesURLs.append(url) }
        }
        
        func completeImageLoading(with imageData: Data = Data(), at index: Int = 0) {
            imageRequests[index].completion(.success(imageData))
        }
        
        func completeImageLoadingWithError(at index: Int = 0) {
            let error = NSError(domain: "an error", code: 0)
            imageRequests[index].completion(.failure(error))
        }
    }
}
