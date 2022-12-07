import StorageService
import UIKit

//MARK: ===================================  HEADER ===================================

public var screenWidth: CGFloat {
    return UIScreen.main.bounds.width
}
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.height
}

public let sizeProfileImage: CGFloat = absoluteWidth / 3


//MARK: ===================================  LOGIN  ===================================
public var dictionaryOfUsers: [String: Int] = [ ///словарь емейлов пользователей
    "11@ru.ru": 0,
    "22@ru.ru": 1
]

public struct Users {
    var userName: String
    var password: String
    var fullName: String
    var userImage: UIImage
    var status: String
}
public var users: [Users] = [   ///профили пользователей
    Users(userName: "11@ru.ru", password: "111111", fullName: "Obi Wan Kenobi", userImage: UIImage(named: "obiwan")!, status: "Hello, my padavan"),
    Users(userName: "22@ru.ru", password: "222222", fullName: "Darth Vader", userImage: UIImage(named: "darthvader")!, status: "Come with me, son!")
]

public var statusEntry = true


//MARK: ================================== ProfileVC ==================================
public var posts: [Post] = Post.addPosts()


//MARK: ================================== MainTabBar =================================

public var topBarHeight: CGFloat = 0

public var absoluteWidth: CGFloat {
    return  UIScreen.main.bounds.height < UIScreen.main.bounds.width ?
            UIScreen.main.bounds.height : UIScreen.main.bounds.width
}

