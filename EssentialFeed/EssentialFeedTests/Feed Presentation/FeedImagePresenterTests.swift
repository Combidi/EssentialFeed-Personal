//
//  Created by Peter Combee on 21/03/2022.
//

import XCTest

final class FeedImagePresenter {
    init(view: Any) {
        
    }
}

final class FeedImagePresenterTests: XCTestCase {
    
    func test_init_doesNotSendMessagesToView() {
        let (_, view) = makeSUT()
        
        XCTAssertTrue(view.messages.isEmpty, "Expected no messages")
    }
    
    // MARK: - Helpers
    private func makeSUT() -> (FeedImagePresenter, ViewSpy) {
        let view = ViewSpy()
        let sut = FeedImagePresenter(view: view)
        return (sut, view)
    }
    
    private class ViewSpy {
        let messages = [Any]()
    }
}
