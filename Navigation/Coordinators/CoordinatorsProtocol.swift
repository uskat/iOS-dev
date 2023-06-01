
import UIKit

protocol CoordinatorsProtocol: AnyObject {
    var childCoordinators: [CoordinatorsProtocol] { get }
    func start() -> UIViewController
//    func addChildCoordinator(_ coordinator: CoordinatorsProtocol)
//    func removeChildCoordinator(_ coordinator: CoordinatorsProtocol)
}

protocol CoordinatorProtocol: CoordinatorsProtocol {
    var branch: Branch? { get }
    var branchName: Branch.BranchName { get }
    func push(to page: Branch.BranchName.FeedBranch)

//    func setup()
//    func present(_ presentation: FeedProtocol.Presentation)
}
