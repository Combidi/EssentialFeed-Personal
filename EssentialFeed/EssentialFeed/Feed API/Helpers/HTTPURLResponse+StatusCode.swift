//
//  Created by Peter Combee on 04/04/2022.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { 200 }

    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
