
import UIKit

final class Checker {
    static let shared = Checker()
    private var userName: String = users[0].userName
    private var password: String = users[0].password
    
    private init() {}
    
    func check(login: String, pass: String) -> Bool {
        login == userName && pass == password
    }
}


