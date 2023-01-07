
import UIKit

class ProfileCoordinator: ModuleCoordinatorsProtocol {
    
    func start() -> UIViewController {
        let profileVC = LogInViewController()
        let loginInspector = MyLoginFactory.shared.makeLoginInspector()
        profileVC.loginDelegate = loginInspector
        
        let nvc = UINavigationController(rootViewController: profileVC)
        profileVC.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        return nvc
    }
    
}
