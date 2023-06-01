
import UIKit

class ProfileViewModel: ViewModelProtocol {
    
    var user: User?
    var photos = Photo.addPhotos()
    weak var coordinator: ProfileCoordinator?
    
#if DEBUG
    let userService = TestUserService.shared
#else
    let userService = CurrentUserService.shared
#endif
}
