
import Foundation
import UIKit
import ImageIO


extension UIImage {
    
    convenience init?(color: UIColor) {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

extension UIImage {
    
    convenience init?(optimized data: Data, for size: CGSize = .zero) {
        
        let imageSourceData = CGImageSourceCreateWithData(data as CFData, nil)
        
        let maxSize = size == .zero ? 300 : max(size.width, size.height) * 2
        
        let options: CFDictionary = [kCGImageSourceThumbnailMaxPixelSize: maxSize,
                                     kCGImageSourceCreateThumbnailFromImageAlways: true,
                                     kCGImageSourceCreateThumbnailWithTransform: true] as CFDictionary
        
        guard let imageSource = imageSourceData,
              let scaledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options) else { return nil }
        
        let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil)
        
        self.init(cgImage: scaledImage)
    }
}


