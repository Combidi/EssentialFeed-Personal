//
//  Created by Peter Combee on 14/03/2022.
//

import UIKit

extension UIImage {
    static func make(withColor color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        return UIGraphicsImageRenderer(size: rect.size, format: format).image { renderContext in
            color.setFill()
            renderContext.fill(rect)
        }
    }
}
