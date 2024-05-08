

import UIKit


typealias StartEndPoint = (startPoint: CGPoint, endPoint: CGPoint)

public enum GradientDirection {
    case topToBottom
    case bottomToTop
    case leftToRight
    case rightToLeft
    case topLeftToBottomRight
    case topRightToBottomLeft
    case bottomLeftToTopRight
    case bottomRightToTopLeft
    case custom
    case cell
    
    
    ///
    var startEndPoint: StartEndPoint {
        switch self {
        case .topToBottom:
            return (CGPoint(x: 0.5, y: 0.0),
                    CGPoint(x: 0.5, y: 1.0))
        case .bottomToTop:
            return (CGPoint(x: 0.5, y: 1.0),
                    CGPoint(x: 0.5, y: 0.0))
        case .leftToRight:
            return (CGPoint(x: 0.0, y: 0.5),
                    CGPoint(x: 1.0, y: 0.5))
        case .rightToLeft:
            return (CGPoint(x: 1.0, y: 0.5),
                    CGPoint(x: 0.0, y: 0.5))
        case .topLeftToBottomRight:
            return (CGPoint.zero,
                    CGPoint(x: 1.0, y: 1.0))
        case .topRightToBottomLeft:
            return (CGPoint(x: 1.0, y: 0.0),
                    CGPoint(x: 0.0, y: 1.0))
        case .bottomLeftToTopRight:
            return (CGPoint(x: 0.0, y: 1.0),
                    CGPoint(x: 1.0, y: 0.0))
        case .bottomRightToTopLeft:
            return (CGPoint(x: 1.0, y: 1.0),
                    CGPoint(x: 0.0, y: 0.0))
        case .custom:
            return (CGPoint(x: 0.137, y: 0.0),
                    CGPoint(x: 0.863, y: 1))
        case .cell:
            return (CGPoint(x: 0.318, y: 0.0),
                    CGPoint(x: 0.682, y: 1))
        }
    }
    
}

class GradientLayer: CAGradientLayer {
    
    private var direction: GradientDirection = .leftToRight
    
    convenience init(direction: GradientDirection, colors: [UIColor], cornerRadius: CGFloat = 0, locations: [Double]? = nil) {
        
        self.init()
        
        self.direction = direction
        self.needsDisplayOnBoundsChange = true
        self.colors = colors.map { $0.cgColor }
        self.startPoint = self.direction.startEndPoint.startPoint
        self.endPoint = self.direction.startEndPoint.endPoint
        self.cornerRadius = cornerRadius
        self.locations = locations?.map { NSNumber(value: $0) }
        
    }
}

extension UIView {
    
    func addGradient(direction: GradientDirection = .leftToRight,
                     colors: [UIColor],
                     cornerRadius: CGFloat = 0,
                     locations: [Double]? = nil) {
        
        let gradient = GradientLayer(direction: direction,
                                     colors: colors,
                                     cornerRadius: cornerRadius,
                                     locations: locations)
        
        gradient.frame = self.bounds
        
        layer.addSublayer(gradient)
    }
}
