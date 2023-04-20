
import UIKit

class ProfileViewModel {
    
    var user: User?
    var photos = Photo.addPhotos()

#if DEBUG
    let userService = TestUserService.shared
#else
    let userService = CurrentUserService.shared
#endif
}
