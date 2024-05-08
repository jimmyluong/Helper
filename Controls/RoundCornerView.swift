

import UIKit

@IBDesignable
class RoundCornerView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 24.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            self.clipsToBounds = cornerRadius > 0
        }
    }
    
}
