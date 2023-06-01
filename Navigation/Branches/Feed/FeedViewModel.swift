
import UIKit

protocol FeedViewModelProtocol: ViewModelProtocol {
//    var onStateDidChange: ((ListViewModel.State) -> Void)? { get set }
//    func updateState(viewInput: ListViewModel.ViewInput)
    var coordinator: CoordinatorProtocol? { get set }
    func load(to page: Branch.BranchName.FeedBranch)
}

class FeedViewModel: FeedViewModelProtocol {
    weak var coordinator: CoordinatorProtocol?
    
    func load(to page: Branch.BranchName.FeedBranch) {
        print("coo + page = \(coordinator) + \(page)")
        coordinator?.push(to: page)
    }
}
