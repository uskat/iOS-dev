
import UIKit

protocol UserService {
    func checkUser(_ login: String) -> User?
}

class User {
    var login: String
    var password: String
    var fullName: String
    var avatar: UIImage
    var status: String
    
    init(login: String = "", password: String = "", fullName: String = "", avatar: UIImage = UIImage(), status: String = "") {
        self.login = login
        self.password = password
        self.fullName = fullName
        self.avatar = avatar
        self.status = status
    }
}

public class CurrentUserService: UserService {
    var user: User?

    func checkUser(_ login: String) -> User? {
        return login == user?.login ? user : nil
    }
}

class TestUserService: UserService {
    var user: User?

    func checkUser(_ login: String) -> User? {
        var returnedData: User?
        if let user = user {
            if login == user.login {
                returnedData = user
            } else {
                returnedData = nil
            }
        }
        return returnedData
    }
}
