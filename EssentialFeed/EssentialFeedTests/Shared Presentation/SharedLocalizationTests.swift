//
//  Created by Peter Combee on 17/06/2022.
//

import XCTest
import EssentialFeed

class SharedLocalizationTests: XCTestCase {
    
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Shared"
        let bundle = Bundle(for: LoadResourcePresenter<Any, DummyView>.self)
        assertLocalizedKeysAndValuesExist(in: bundle, table)
    }
    
    private class DummyView: ResourceView {
        func display(_ viewModel: Any) {}
    }
}
