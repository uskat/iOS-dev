
import UIKit

protocol FeedViewModelProtocol: ViewModelProtocol {
    var coordinator: CoordinatorProtocol? { get set }
    func load(to page: Branch.BranchName.FeedBranch)
}

class FeedViewModel: FeedViewModelProtocol {
    weak var coordinator: CoordinatorProtocol?
    
    func load(to page: Branch.BranchName.FeedBranch) {
        coordinator?.push(to: page)
    }
}
