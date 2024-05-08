
import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = #colorLiteral(red: 0.3607843137, green: 0.6431372549, blue: 0.6392156863, alpha: 1)
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.NotoSansJP(.bold, size: 20),
                                                                        NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)]
        self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.NotoSansJP(.bold, size: 20),
                                                                             NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)]
    }
    
    func popBack(_ nb: Int) {
            let viewControllers: [UIViewController] = self.viewControllers
            guard viewControllers.count < nb else {
                self.popToViewController(viewControllers[viewControllers.count - nb], animated: true)
                return
            }
        }
}
