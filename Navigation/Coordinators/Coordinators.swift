
import UIKit

class Coordinators: CoordinatorsProtocol {
 
    private(set) var childCoordinators: [CoordinatorsProtocol] = []
    let tabBarController = UITabBarController()
    
    private let factory: BranchesFactory

    init(factory: BranchesFactory) {
        self.factory = factory
    }

    func start() -> UIViewController {
        print("start")
        let feedCoordinator = FeedCoordinator(branchName: .feed(controller: .feed), factory: factory)
        let profileCoordinator = ProfileCoordinator(branchName: .profile(controller: .profile), factory: factory)
        UITabBar.appearance().backgroundColor = .systemGray6

        tabBarController.viewControllers = [
            feedCoordinator.start(),
            profileCoordinator.start() //(authKey: false)
        ]
        return tabBarController
    }
    
    func reload(authKey: Bool) -> UIViewController {
        let feedCoordinator = FeedCoordinator(branchName: .feed(controller: .feed), factory: factory)
        let profileCoordinator = ProfileCoordinator(branchName: .profile(controller: .profile), factory: factory)
        
        tabBarController.viewControllers = [
//            feedCoordinator.setup(),
            feedCoordinator.start(),
            profileCoordinator.start() //(authKey: authKey)
        ]
        return tabBarController
    }
    
//    //из лекции
//    func addChildCoordinator(_ coordinator: CoordinatorsProtocol) {
//        guard !listOfCoordinators.contains(where: { $0 === coordinator }) else { return }
//        listOfCoordinators.append(coordinator)
//    }
//    
//    func removeChildCoordinator(_ coordinator: CoordinatorsProtocol) {
//        listOfCoordinators = listOfCoordinators.filter { $0 === coordinator }
//    }
}
