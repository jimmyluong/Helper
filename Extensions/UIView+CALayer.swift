
import Foundation
import UIKit

// MARK: Shadow View
extension UIView {
    
    /// Description:  Apply shadow a view corner radius = 0.5 height
    /// - Parameters:
    ///   - color: UIColor of shadow
    ///   - alpha: alpha
    ///   - x: position x
    ///   - y: position y
    ///   - blur: blur
    ///   - spread: spread
    func applyShadowSketch(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / UIScreen.main.scale
        
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            
            layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: bounds.height/2).cgPath
        }
    }
    
    /// Description:  Apply shadow uiview custom corner radius
    /// - Parameters:
    ///   - color: UIColor of shadow
    ///   - alpha: alpha
    ///   - x: position x
    ///   - y: position y
    ///   - blur: blur
    ///   - spread: spread
    ///   - cornerRadius: radius of shadow 
    func applyShadowSketch(color: UIColor, alpha: Float, x: CGFloat, y: CGFloat, blur: CGFloat, spread: CGFloat,
                           cornerRadius: CGFloat = 0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / UIScreen.main.scale
        
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            
            if cornerRadius == 0 {
                layer.shadowPath = UIBezierPath(rect: rect).cgPath
            } else {
                layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).cgPath
            }
        }
    }
    
    
    
    func removeShadowSketch() {
        self.layer.shadowOffset = CGSize(width: 0 , height: 0)
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.cornerRadius = 0.0
        self.layer.shadowRadius = 0.0
        self.layer.shadowOpacity = 0.0
    }
    
    func roundCorners(radius: CGFloat , mask: CACornerMask) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = mask
    }
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: UIColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        switch side {
        case .Left: border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness); break
        }
        
        border.backgroundColor = color.cgColor
        layer.addSublayer(border)
        
    }
}

// MARK: NIB 
extension UIView {
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
