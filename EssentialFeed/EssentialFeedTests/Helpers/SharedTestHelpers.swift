//
//  Created by Peter Combee on 08/01/2022.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "Any-error", code: 0)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}
