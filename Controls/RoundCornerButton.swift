
import UIKit

@IBDesignable
class RoundCornerButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = cornerRadius > 0
        }
    }
}
