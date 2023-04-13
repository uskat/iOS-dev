
import UIKit

class ProfileCoordinator: ModuleCoordinatorsProtocol {

    func start() -> UIViewController {
        let loginViewModel = LoginViewModel()
        let viewModel = ProfileViewModel()
        let profileVC = LogInViewController(loginViewModel: loginViewModel, viewModel: viewModel, coordinator: self)
        let loginInspector = MyLoginFactory.shared.makeLoginInspector()
        profileVC.loginDelegate = loginInspector
        print("* ProfileCoordinator. loginInspector = \(loginInspector) и \(profileVC.loginDelegate!)")
        
        let nvc = UINavigationController(rootViewController: profileVC)
        profileVC.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        return nvc
    }
}
