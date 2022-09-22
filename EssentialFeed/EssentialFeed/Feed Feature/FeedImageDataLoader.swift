//
//  Created by Peter Combee on 22/02/2022.
//

import Foundation

public protocol FeedImageDataLoader {
    func loadImageData(from: URL) throws -> Data
}
