import StorageService
import UIKit

//MARK: - HEADER

public var statusText = "Waiting for something....."

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

public let sizeProfileImage: CGFloat = absoluteWidth / 3


//MARK: - LOGIN
public let myLogin = "11@ru.ru"
public let myPass = "111111"
public var statusEntry = true
public var errors: [ErrorInEmail] = []

//MARK: - ProfileVC
public var posts: [Post] = Post.addPosts()


//MARK: - MainTabBar

public var topBarHeight: CGFloat = 0

public var absoluteWidth: CGFloat {
    return  UIScreen.main.bounds.height < UIScreen.main.bounds.width ?
            UIScreen.main.bounds.height : UIScreen.main.bounds.width
}

