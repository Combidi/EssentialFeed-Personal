//
//  Created by Peter Combee on 17/04/2022.
//

import EssentialFeed
import Foundation

public final class FeedImageDataLoaderWithFallBackComposite: FeedImageDataLoader {
    private let primary: FeedImageDataLoader
    private let fallback: FeedImageDataLoader
    
    public init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    private class TaskWrapper: FeedImageDataLoaderTask {
        var wrapped: FeedImageDataLoaderTask?
        
        func cancel() {
            wrapped?.cancel()
        }
    }
    
    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        let task = TaskWrapper()
        task.wrapped = primary.loadImageData(from: url) { [weak self] primaryLoaderResult in
            switch primaryLoaderResult {
            case let .success(data):
                completion(.success(data))
                
            case .failure:
                task.wrapped = self?.fallback.loadImageData(from: url, completion: completion)
                
            }
        }
        return task
    }
}
