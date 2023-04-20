
import UIKit

class ProfileCoordinator: ModuleCoordinatorsProtocol {
    let loginViewModel = LoginViewModel()
    let viewModel = ProfileViewModel()
    
    func start(authKey: Bool) -> UIViewController {
        let vc = authKey ?
        ProfileViewController(viewModel: viewModel, coordinator: self) :
        LogInViewController(loginViewModel: loginViewModel, viewModel: viewModel, coordinator: self)
        
        if !authKey {
            let loginInspector = MyLoginFactory.shared.makeLoginInspector()
            (vc as! LogInViewController).loginDelegate = loginInspector
            vc.title = "Login"
        } else {
            vc.title = "Profile"
        }
        
        let nvc = UINavigationController(rootViewController: vc)
        vc.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        UIApplication.shared.window?.rootViewController = nvc
        return nvc
    }
    
    func reload() {

    }
}
