
import Foundation
import UIKit


extension UIViewController {
    
    func configureDismissKeyboard() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        tapGestureRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer? = nil) {
        sender?.view?.endEditing(true)
    }
    
}


extension UIViewController {
    
    func openSettingsApp() {
        DispatchQueue.main.async {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)")
                    })
                } else {
                    UIApplication.shared.openURL(settingsUrl as URL)
                }
            } else {
                print("Settings not opened")
            }
        }
    }
}


extension UIViewController {
    
    func applySpaceLayoutSketch(space: CGFloat) -> CGFloat {
        
        let ratio = space / 812 // height design
        
        return ratio * UIScreen.main.bounds.height
    }
}


// MARK: Helpers Present View Controller
public typealias HandleAlertAction = (_ alertAction: UIAlertAction, _ index: Int) -> Void

extension UIViewController {
    
    func presentOnTop(_ viewController: UIViewController, animated: Bool) {
        var topViewController = self
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        topViewController.present(viewController, animated: animated)
    }
    
    
    func presentCancelAlert(title: String, message: String, cancel: String, action: (() -> Void)?) {
        
        // check view controller presented
        if self.presentedViewController != nil {
            Logger.error("\(self.description) only present one other view controller at a time")
            return
        }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: cancel, style: .cancel) { _  in
            action?()
        }
        alertVC.addAction(cancelButton)
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.presentOnTop(alertVC, animated: true)
        }
    }
    
    
    func presentAlertController(title: String, message: String,
                                cancel: String, cancelAction: (() -> Void)? = nil,
                                others: [String], othersAction: HandleAlertAction?) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelButton = UIAlertAction(title: cancel, style: .cancel) { _ in
            cancelAction?()
        }
        alertVC.addAction(cancelButton)
        
        others
            .enumerated()
            .forEach { (index, element) in
                let action = UIAlertAction(title: element, style: .default) { _action in
                    othersAction!(_action, index)
                }
                alertVC.addAction(action)
        }
        
        if let viewController = UIApplication.shared.keyWindow?.rootViewController {
            viewController.presentOnTop(alertVC, animated: true)
        }
    }
}
