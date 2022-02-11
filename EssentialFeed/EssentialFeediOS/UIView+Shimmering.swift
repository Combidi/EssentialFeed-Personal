//
//  Created by Peter Combee on 11/02/2022.
//

import UIKit

extension UIView {
    public var isShimmering: Bool {
        return layer.mask?.animation(forKey: shimmeringAnimationKey) != nil
    }
    
    private var shimmeringAnimationKey: String {
        return "shimmer"
    }
    
    func startShimmering() {
        let white = UIColor.white.cgColor
        let alpha = UIColor.white.withAlphaComponent(0.7).cgColor
        let width = bounds.width
        let height = bounds.height
        
        let gratient = CAGradientLayer()
        gratient.colors = [alpha, white, alpha]
        gratient.startPoint = CGPoint(x: 0.0, y: 0.4)
        gratient.endPoint = CGPoint(x: 1.0, y: 0.6)
        gratient.locations = [0.4, 0.5, 0.6]
        gratient.frame = CGRect(x: -width, y: 0, width: width*3, height: height)
        layer.mask = gratient
        
        let animation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.locations))
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 1
        animation.repeatCount = .infinity
        gratient.add(animation, forKey: shimmeringAnimationKey)
    }
    
    func stopShimering() {
        layer.mask = nil
    }
}
