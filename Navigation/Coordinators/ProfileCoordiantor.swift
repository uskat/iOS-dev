
import UIKit

class ProfileCoordinator: CoordinatorProtocol {
    
    let branchName: Branch.BranchName
    private let factory: BranchesFactory
    private(set) var branch: Branch?
    private(set) var childCoordinators: [CoordinatorsProtocol] = []

    init(branchName: Branch.BranchName, factory: BranchesFactory) {
        self.branchName = branchName
        self.factory = factory
    }
//    enum Presentation {
//        
//    }
//    

    func start() -> UIViewController{
        let branch = factory.createBranch(name: branchName)
        print("profileBranch = \(branch)")
        let vc = branch.view
        vc.tabBarItem = branchName.tabBatItem
        (branch.viewModel as? ProfileViewModel)?.coordinator = self
        self.branch = branch
        return vc
    }
    
    func push(to page: Branch.BranchName.FeedBranch) {}

//    func start(authKey: Bool) -> UIViewController {
//        let vc = authKey ?
//        ProfileViewController(viewModel: viewModel, coordinator: self) :
//        LogInViewController(loginViewModel: loginViewModel, viewModel: viewModel, coordinator: self)
//
//        if !authKey {
//            let loginInspector = MyLoginFactory.shared.makeLoginInspector()
//            (vc as! LogInViewController).loginDelegate = loginInspector
//            vc.title = "Login"
//        } else {
//            vc.title = "Profile"
//        }
//
//        let nvc = UINavigationController(rootViewController: vc)
//        vc.tabBarItem.image = UIImage(systemName: "person.crop.circle")
//        UIApplication.shared.window?.rootViewController = nvc
//        return nvc
//    }
    
//    func reload() {
//
//    }
//    
//    func present(_ presentation: Presentation) {
//        
//    }
}
