
import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: BaseNavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func removeChildCoordinators()
}

class BaseCoordinator: Coordinator {
    
    var navigationController = BaseNavigationController()
    var childCoordinators = [Coordinator]()
    var parentCoordinator: Coordinator?
    
    deinit {
        Logger.debug("DeInit 👀👀 \(self)")
    }
    
    func start() {
        fatalError("Start method should be implemented.")
    }
    
    func start(coordinator: Coordinator) {
        self.childCoordinators += [coordinator]
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    func removeChildCoordinators() {
        self.childCoordinators.forEach { $0.removeChildCoordinators() }
        self.childCoordinators.removeAll()
        self.parentCoordinator = nil /// remove reference strong
        self.navigationController.viewControllers.removeAll()
    }
    
    func didFinish(coordinator: Coordinator) {
        if let index = self.childCoordinators.firstIndex(where: { $0 === coordinator }) {
            self.childCoordinators.remove(at: index)
        }
    }
}
