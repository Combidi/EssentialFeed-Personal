//
//  Created by Peter Combee on 11/04/2022.
//

import Foundation
import CoreData

extension CoreDataFeedStore: FeedImageDataStore {
    
    public func insert(_ data: Data, for url: URL, completion: @escaping (FeedImageDataStore.InsertionResult) -> Void) {
        perform { context in
            guard let image = try? ManagedFeedImage.first(with: url, in: context) else { return }

            image.data = data
            try? context.save()
        }
    }
    
    public func retrieve(dataForURL url: URL, completion: @escaping (FeedImageDataStore.RetrievalResult) -> Void) {
        perform { context in
            completion(Result {
                return try ManagedFeedImage.first(with: url, in: context)?.data
            })
        }
    }
}

extension ManagedFeedImage {
    static func first(with url: URL, in context: NSManagedObjectContext) throws -> ManagedFeedImage? {
         let request = NSFetchRequest<ManagedFeedImage>(entityName: entity().name!)
         request.predicate = NSPredicate(format: "%K = %@", argumentArray: [#keyPath(ManagedFeedImage.url), url])
         request.returnsObjectsAsFaults = false
         request.fetchLimit = 1
         return try context.fetch(request).first
     }
}
