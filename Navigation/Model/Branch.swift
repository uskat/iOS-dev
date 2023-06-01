
import UIKit

protocol ViewModelProtocol: AnyObject {
}

struct Branch {
    enum BranchName {
        case feed(controller: FeedBranch)
        case profile(controller: ProfileBranch)
        
        enum FeedBranch {
            case feed
            case post
            case info
        }
        
        enum ProfileBranch {
            case login
            case profile
            case postDetailed
            case photoCollection
            case photoDetailed
        }
    }
    
    let branchName: BranchName
    let view: UIViewController
    let viewModel: ViewModelProtocol
}

extension Branch.BranchName {
    var tabBatItem: UITabBarItem {
        switch self {
            case .feed:
                return UITabBarItem(title: "Feed", image: UIImage(systemName: "rectangle.grid.2x2"), tag: 0)
            case .profile:
                return UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 1)
        }
    }
}


