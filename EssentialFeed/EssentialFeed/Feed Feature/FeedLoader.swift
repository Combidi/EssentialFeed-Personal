//
//  Created by Peter Combee on 21/12/2021.
//

public enum LoadFeedResult<Error: Swift.Error> {
    case success([FeedItem])
    case failure(Error)
}

extension LoadFeedResult: Equatable where Error: Equatable {}

protocol FeedLoader {
    associatedtype Error: Swift.Error
    func loadItems(completion: @escaping (LoadFeedResult<Error>) -> Void)
}
