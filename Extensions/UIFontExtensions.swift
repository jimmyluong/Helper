
import Foundation
import UIKit

extension UIFont {

    // Define font style is enum
    enum NotoSansJPType: String {
        case regular =      "NotoSansJP-Regular"
        case medium =       "NotoSansJP-Medium"
        case bold =         "NotoSansJP-Bold"
    }
    
    static func NotoSansJP(_ type: NotoSansJPType = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: type.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
