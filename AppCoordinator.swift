
import Foundation
import UIKit
import RxSwift
import Swinject

class AppCoordinator: BaseCoordinator {
    
    private let disposeBag = DisposeBag()
    private let authenticationService: AuthenticationService
    private let socketEventsService: SocketEventsService
    private var window = UIWindow(frame: UIScreen.main.bounds)
    
    init(authenticationService: AuthenticationService, socketEventsService: SocketEventsService) {
        self.authenticationService = authenticationService
        self.socketEventsService = socketEventsService
        super.init()
        self.setupBindings()
    }
    
    
    override func start() {
        self.window.makeKeyAndVisible()
        self.authenticationService.sessionState == nil
            ? self.showSignIn()
            : self.showMainScreen()
    }
    
    private func setupBindings() {
        
        self.authenticationService
            .didSignIn
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.showMainScreen()
            })
            .disposed(by: self.disposeBag)
        
        self.authenticationService
            .didSignOut
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                self?.showSignIn()
            })
            .disposed(by: self.disposeBag)
    }
    
}

// MARK: Navigation
extension AppCoordinator {
    
    private func showSignIn() {
        self.removeChildCoordinators()
        
        let coordinator = AppDelegate.container.resolve(SignInCoordinator.self)!
        coordinator.navigationController = BaseNavigationController()
        self.start(coordinator: coordinator)
        
        ViewControllerUtils.setRootViewController(
            window: self.window,
            viewController: coordinator.navigationController,
            withAnimation: true)
    }
    
    
    private func showMainScreen() {
        self.removeChildCoordinators()
        let coordinator = AppDelegate.container.resolve(PatientListCoordinator.self)!
        coordinator.navigationController = BaseNavigationController()
        self.start(coordinator: coordinator)
        
        self.socketEventsService.reconnectExtraHeader()
        
        ViewControllerUtils.setRootViewController(
            window: self.window,
            viewController: coordinator.navigationController,
            withAnimation: true)
        
    }
}

// MARK: //-------
enum ViewControllerUtils {
    
    static func setRootViewController(window: UIWindow, viewController: UIViewController, withAnimation: Bool) {

        if !withAnimation {
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            return
        }

        if let snapshot = window.snapshotView(afterScreenUpdates: true) {
            viewController.view.addSubview(snapshot)
            window.rootViewController = viewController
            window.makeKeyAndVisible()
            
            UIView.animate(withDuration: 0.3, animations: {
                snapshot.layer.opacity = 0
            }, completion: { _ in
                snapshot.removeFromSuperview()
            })
        }
    }
}
