//
//  Created by Peter Combee on 19/06/2022.
//

final class WeakRefVirtualProxy<T: AnyObject> {
    private(set) weak var object: T?
    
    init(_ object: T) {
        self.object = object
    }
}
