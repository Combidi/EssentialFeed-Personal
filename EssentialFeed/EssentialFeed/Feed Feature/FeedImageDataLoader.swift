//
//  Created by Peter Combee on 22/02/2022.
//

import Foundation

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    
    func loadImageData(from: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
