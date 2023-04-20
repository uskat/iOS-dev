
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
    let tabBarController = UITabBarController()
    
    func start() -> UIViewController {
        let feedCoordinator = FeedCoordinator()
        let profileCoordinator = ProfileCoordinator()
        
        UITabBar.appearance().backgroundColor = .systemGray6

        tabBarController.viewControllers = [
            feedCoordinator.start(),
            profileCoordinator.start(authKey: false)
        ]
        return tabBarController
    }
    
    func reload(authKey: Bool) -> UIViewController {
        let feedCoordinator = FeedCoordinator()
        let profileCoordinator = ProfileCoordinator()
        
        tabBarController.viewControllers = [
            feedCoordinator.start(),
            profileCoordinator.start(authKey: authKey)
        ]
        return tabBarController
    }
    
    
    
    //из лекции
    func addChildCoordinator(_ coordinator: CoordinatorsProtocol) {
        guard !listOfCoordinators.contains(where: { $0 === coordinator }) else { return }
        listOfCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: CoordinatorsProtocol) {
        listOfCoordinators = listOfCoordinators.filter { $0 === coordinator }
    }
}
