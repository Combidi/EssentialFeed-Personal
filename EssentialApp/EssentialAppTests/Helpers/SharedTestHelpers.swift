//
//  Created by Peter Combee on 17/04/2022.
//

import Foundation

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    Data("any data".utf8)
}

func anyNSError() -> Error {
    return NSError(domain: "any error", code: 0)
}
