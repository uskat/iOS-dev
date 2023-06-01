
import UIKit

final class BranchesFactory {
    
    static let shared = BranchesFactory()
    private init () {}
//    private let networkService: NetworkServiceProtocol

//    init(networkService: NetworkServiceProtocol) {
//        self.networkService = networkService
//    }

    func createBranch(name branchName: Branch.BranchName) -> Branch {
        switch branchName {
        case .feed:
            let viewModel = FeedViewModel()
            let vc = FeedViewController(viewModel: viewModel)
            let view = UINavigationController(rootViewController: vc)
            return Branch(branchName: branchName, view: view, viewModel: viewModel)
        case .profile:
            let viewModel = ProfileViewModel()
//            let coordinator = ProfileCoordinator(branchName: .profile(controller: .profile), factory: self)
            let vc = ProfileViewController(viewModel: viewModel)
            vc.navigationController?.isNavigationBarHidden = true
            let view = UINavigationController(rootViewController: vc)            
            
//            let coordinator = ProfileCoordinator()
//            let vc = ProfileViewController(viewModel: viewModel, coordinator: coordinator)
//            let view = UINavigationController(rootViewController: vc)
            return Branch(branchName: branchName, view: view, viewModel: viewModel)
        }
    }
}

//final class AppFactory {
//    private let networkService: NetworkServiceProtocol
//
//    init(networkService: NetworkServiceProtocol) {
//        self.networkService = networkService
//    }
//
//    func makeModule(ofType moduleType: Module.ModuleType) -> Module {
//        switch moduleType {
//        case .booksList:
//            let viewModel = ListViewModel(networkService: networkService)
//            let view = UINavigationController(rootViewController: ListViewController(viewModel: viewModel))
//            return Module(viewModel: viewModel, view: view)
//        case .about:
//            let viewModel = AboutViewModel()
//            let view = UINavigationController(rootViewController: AboutViewController(viewModel: viewModel))
//            return Module(viewModel: viewModel, view: view)
//        }
//    }
//}
