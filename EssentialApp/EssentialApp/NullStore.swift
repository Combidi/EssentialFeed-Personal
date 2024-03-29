//
//  Created by Peter Combee on 18/09/2022.
//

import Foundation
import EssentialFeed

final class NullStore: FeedStore {    
    func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        completion(.success(()))
    }
    
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        completion(.success(()))
    }
    
    func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.success(.none))
    }
}

extension NullStore: FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws {}
    func retrieve(dataForURL url: URL) throws -> Data? { .none}
}
