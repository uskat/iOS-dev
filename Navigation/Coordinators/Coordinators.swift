
import UIKit

protocol CoordinatorsProtocol: AnyObject {
    var listOfCoordinators: [CoordinatorsProtocol] { get }
    func start() -> UIViewController
    func addChildCoordinator(_ coordinator: CoordinatorsProtocol)
    func removeChildCoordinator(_ coordinator: CoordinatorsProtocol)
}

protocol ModuleCoordinatorsProtocol {
    
}

class Coordinators: CoordinatorsProtocol {
 
    var listOfCoordinators: [CoordinatorsProtocol] = []
    
    func start() -> UIViewController {
        let feedCoordinator = FeedCoordinator()
        let profileCoordinator = ProfileCoordinator()
        
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = .systemGray6

        tabBarController.viewControllers = [
            feedCoordinator.start(),
            profileCoordinator.start()
        ]
        return tabBarController
    }
    
    func addChildCoordinator(_ coordinator: CoordinatorsProtocol) {
        guard !listOfCoordinators.contains(where: { $0 === coordinator }) else { return }
        listOfCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: CoordinatorsProtocol) {
        listOfCoordinators = listOfCoordinators.filter { $0 === coordinator }
    }
}
