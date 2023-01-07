
import UIKit

class FeedCoordinator: ModuleCoordinatorsProtocol {
//    let moduleType: Module.ModuleType
//    
//    private(set) var coordinators: [CoordinatorsProtocol] = []
//    private(set) var module: Module?
//    
//    init(moduleType: Module.ModuleType, module: Module? = nil) {
//        self.moduleType = moduleType
//        self.module = module
//    }
    
    func start() -> UIViewController {
        let feedViewModel = FeedViewModel()
        let feedVC = FeedViewController(feedViewModel: feedViewModel, feedCoordinator: self)
        let nvc = UINavigationController(rootViewController: feedVC)
        feedVC.title = "Feed"
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "rectangle.grid.2x2")
        return nvc
    }
    
}
