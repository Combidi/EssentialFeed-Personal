//
//  Created by Peter Combee on 05/06/2022.
//

import Foundation

internal final class ImageCommentsMapper {
    private struct Root: Decodable  {
        let items: [RemoteFeedItem]
    }
        
    internal static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteImageCommentsLoader.Error.invalidData
        }
        
        return root.items
    }
}
