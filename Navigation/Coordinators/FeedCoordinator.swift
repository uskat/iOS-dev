
import UIKit

class FeedCoordinator: ModuleCoordinatorsProtocol {
    
    func start() -> UIViewController {
        let viewModel = FeedViewModel()
        let feedVC = FeedViewController(viewModel: viewModel, coordinator: self)
        let nvc = UINavigationController(rootViewController: feedVC)
        feedVC.title = "Feed"
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "rectangle.grid.2x2")
        return nvc
    }
}
