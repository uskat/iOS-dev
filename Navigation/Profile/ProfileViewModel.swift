
import UIKit

class ProfileViewModel {
    
    var user: User?
    var photos = Photo.addPhotos()

#if DEBUG
    let userService = TestUserService()
#else
    let userService = CurrentUserService()
#endif
}
