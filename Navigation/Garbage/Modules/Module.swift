//
//import UIKit
//
//protocol ViewModelProtocol: AnyObject {
//    
//}
//
//struct Module {
//    enum ModuleType {
//        case feed
//        case profile
//    }
//    let moduleType: ModuleType
//    let view: UIViewController
//    let viewModel: ViewModelProtocol
//}
//
//extension Module.ModuleType {
//    var tabBatItem: UITabBarItem {
//        switch self {
//            case .feed: return UITabBarItem(title: "Feed!", image: UIImage(systemName: "rectangle.grid.2x2"), tag: 0)
//            case .profile: return UITabBarItem(title: "Profile!", image: UIImage(systemName: "person.crop.circle"), tag: 1)
//        }
//    }
//}
