
import UIKit

@IBDesignable
class RoundCornerGrayView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 8.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = cornerRadius > 0
            self.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
        }
    }
    
}
