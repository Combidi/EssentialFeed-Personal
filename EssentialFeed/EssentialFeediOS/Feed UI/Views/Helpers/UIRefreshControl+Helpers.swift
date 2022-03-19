//
//  Created by Peter Combee on 19/03/2022.
//

import UIKit

 extension UIRefreshControl {
     func update(isRefreshing: Bool) {
         isRefreshing ? beginRefreshing() : endRefreshing()
     }
 }
