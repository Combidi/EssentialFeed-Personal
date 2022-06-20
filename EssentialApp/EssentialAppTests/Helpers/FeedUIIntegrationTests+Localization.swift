//
//  Created by Peter Combee on 14/03/2022.
//

import XCTest
import EssentialFeed

extension FeedUIIntegrationTests {
    class DummyView: ResourceView {
        func display(_ viewModel: Any) {}
    }
    
    var loadError: String {
        LoadResourcePresenter<Any, DummyView>.loadError
    }
    
    var feedTitle: String {
        FeedPresenter.title
    }
}
