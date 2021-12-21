//
//  Created by Peter Combee on 21/12/2021.
//

enum LoadFeedResult {
    case success([FeedItem])
    case error(Error)
}

protocol FeedLoader {
    func loadItems(completion: @escaping (LoadFeedResult) -> Void)
}
