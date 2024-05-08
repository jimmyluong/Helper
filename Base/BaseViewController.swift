
import UIKit
import SVProgressHUD

class BaseViewController: UIViewController {
    
    private var accountViewModel: AccountViewModel? = AppDelegate.container.resolve(AccountViewModel.self)
    
    deinit {
        Logger.debug("DeInit 👀👀 \(self.description)")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .darkContent
        } else {
            return .default
        }
    }
    
    var didTapBack: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDismissKeyboard()
        self.setupBackButtonItem()
        self.setupNavigationBar()
    }
}

// MARK: Custom Navigation Bar
extension BaseViewController: UIGestureRecognizerDelegate {
    
    private func setupBackButtonItem() {
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 42, height: 42))
        backButton.setImage(#imageLiteral(resourceName: "back_navibar_btn"), for: .normal)
        backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    @objc private func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.3607843137, green: 0.6431372549, blue: 0.6392156863, alpha: 1)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.NotoSansJP(.bold, size: 20),
                                                                        NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.NotoSansJP(.bold, size: 20),
                                                                             NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3098039216, green: 0.3098039216, blue: 0.3098039216, alpha: 1)]
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.extendedLayoutIncludesOpaqueBars = true
    }
}

extension BaseViewController {
    
    func addAccountBarButton() {
        let accountButton = UIButton(frame: CGRect(x: 0, y: 0, width: 42, height: 42))
        accountButton.setImage(#imageLiteral(resourceName: "btn_setting"), for: .normal)
        accountButton.addTarget(self, action: #selector(handleTapAccount(_:)), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: accountButton)
    }
    
    @objc
    private func handleTapAccount(_ sender: UIButton) {
        let accountViewController = AccountViewController()
        accountViewController.senderButton = sender
        accountViewController.modalPresentationStyle = .overCurrentContext
        
        accountViewController.viewModel = self.accountViewModel
        self.present(accountViewController, animated: false, completion: nil)
    }
}

//MARK: Config SVProgressHUD
extension BaseViewController {
    
    func showProgress(_ contview: UIView) {
        contview.isUserInteractionEnabled = false
        SVProgressHUD.setViewForExtension(contview)
        SVProgressHUD.setContainerView(contview)
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
    
    func hideProgress(_ contview: UIView) {
        contview.isUserInteractionEnabled = true
        SVProgressHUD.dismiss()
    }
}
