
import UIKit

//class FeedCoordinator: Coordinator {
//
//    func start() -> UIViewController {
//        let viewModel = FeedViewModel()
//        let feedVC = FeedViewController(viewModel: viewModel, coordinator: self)
//        let nvc = UINavigationController(rootViewController: feedVC)
//        feedVC.title = "Feed"
//        feedVC.tabBarItem.title = "Feed"
//        feedVC.tabBarItem.image = UIImage(systemName: "rectangle.grid.2x2")
//        return nvc
//    }
//}


final class FeedCoordinator: CoordinatorProtocol {
    
//    var controller = UIViewController()
//    let feedVC = FeedViewController()
//    let feedNC = UINavigationController()
    let branchName: Branch.BranchName
    private let factory: BranchesFactory
    private(set) var branch: Branch?
    private(set) var childCoordinators: [CoordinatorsProtocol] = []

    init(branchName: Branch.BranchName, factory: BranchesFactory) {
        self.branchName = branchName
        self.factory = factory
    }

    //MARK: - НЕ передает Post !!!
    struct Post {
        var title: String
    }

//    init() {
////        children = []
//        print("feed coord start")
////        feedNC = UINavigationController(rootViewController: feedVC)
////        feedNC.tabBarItem = UITabBarItem(title: "Feed",
////                                         image: UIImage(systemName: "text.bubble"),
////                                         selectedImage: UIImage(systemName: "text.bubble.fill"))
////        controller = feedNC
//        print("feed controller = \(controller)")
//    }

    func start() -> UIViewController{
        let branch = factory.createBranch(name: branchName)
        print("feedBranch = \(branch)")
        let view = branch.view
        view.tabBarItem = branchName.tabBatItem
        (branch.viewModel as? FeedViewModel)?.coordinator = self
        print("coo = \((branch.viewModel as? FeedViewModel)?.coordinator)")
        self.branch = branch
        return view
    }
    
    func push(to page: Branch.BranchName.FeedBranch) {
        print(page)
        switch page {
        case .feed:
            let view = FeedViewController(viewModel: branch?.viewModel as! FeedViewModel)
            (branch?.view as? UINavigationController)?.popToRootViewController(animated: true)
        case .post:
            let view = PostViewController()
            (branch?.view as? UINavigationController)?.pushViewController(view, animated: true)
        case .info:
            let view = InfoViewController()
            (branch?.view as? UINavigationController)?.present(view, animated: true)
        }
    }

//    func present(_ presentation: Presentation) {
//        switch presentation {
//        case .post:
//            let post = Post(title: "Post")
//
//            let postVC = PostViewController()
////            postVC.coordinator = self
//            postVC.post = post
//
////            feedNC.pushViewController(postVC, animated: true)
//        case .info:
//            let infoVC = InfoViewController()
//            feedNC.present(infoVC, animated: true, completion: nil)
//        }
//    }
}
