
import UIKit

class LoginInspector: LoginViewControllerDelegate {
    let checker = Checker.shared
    
    func check(login: String, pass: String) -> Bool {
        checker.check(login: login, pass: pass)
    }
}
