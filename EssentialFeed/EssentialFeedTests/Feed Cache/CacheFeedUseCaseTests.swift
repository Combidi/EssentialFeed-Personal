//
//  Created by Peter Combee on 04/01/2022.
//

import XCTest

class LocalFeedLoader {
    init(store: FeedStore) {
        
    }
}

class FeedStore {
    var deleteCacheFeedCallCount = 0
}

class CacheFeedUseCaseTests: XCTestCase {
    
    func test_() {
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCacheFeedCallCount, 0)
    }
}
