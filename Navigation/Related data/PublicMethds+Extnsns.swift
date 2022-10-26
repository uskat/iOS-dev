
import UIKit
import Foundation
import AVFoundation

//MARK: ===================================  HEADER ===================================
extension UILabel {
    func animate(newText: String, characterDelay: TimeInterval) {
        DispatchQueue.main.async {
            self.text = ""
            for (index, character) in newText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.text?.append(character)
                    self.fadeTransition(characterDelay) // это анимация проявления
                    //let systemSoundID: SystemSoundID = 1104
                    //AudioServicesPlaySystemSound (systemSoundID)
}   }   }   }   }

extension UITextField {
    func animate(newText: String, characterDelay: TimeInterval) {
        DispatchQueue.main.async {
            self.placeholder = ""
            for (index, character) in newText.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + characterDelay * Double(index)) {
                    self.placeholder?.append(character)
                    self.fadeTransition(characterDelay) // это анимация проявления
                    //let systemSoundID: SystemSoundID = 1104
                    //AudioServicesPlaySystemSound (systemSoundID)
}   }   }   }   }

extension UIView {
    func fadeTransition(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: "kCATransitionFade")
}   }

//MARK: ===================================  LOGIN  ===================================
func placeHolder(_ textField: UITextField) -> String {
    switch textField.tag {
    case 1: return "Login"
    case 2: return "Password"
    case 3: return "Type new status"
    default: return "Type something..."
}   }
    
public func checkInputedData(_ textField: UITextField, _ alert: UILabel) {
    var lengthFrom = 0
    var lengthTo = 0
    var message = ""
    switch textField.tag {
    case 1: lengthFrom = 1
            lengthTo = 3
            message = "Login must be at least 3 chars"
    case 2: lengthFrom = 1
            lengthTo = 6
            message = "Password must be at least 6 chars"
    case 3: lengthFrom = 1000
            lengthTo = 1000
    default: print("status textField ?")
    }
    
    if let count = textField.text?.count {
        switch count {
        case 0:                     shakeMeBaby(textField)
                                    changeTextFieldColorAndText(textField, placeHolder(textField))
                                    checkStatus(false)
        case lengthFrom..<lengthTo: if textField.tag == 3 {
                                        print("Алерт для строки profileStatus не запускаем!")
                                    } else {
                                        shakeMeBaby(textField)
                                        alertMessageOnTextField(alert, message)
                                        checkStatus(false)
                                    }
        case lengthTo...:           checkStatus(true)
        default:                    break
        }
    }
}

public func validateEmail(_ textField: UITextField) -> String {
    var listOfErrorsToScreen = """
    """
    if textField.tag == 1 {
        if let email = textField.text {
            let validator = EmailValidator(email: email)
            print("validator checked")
            if !validator.checkDomain() {
                for (_, value) in errors.enumerated() {
                    listOfErrorsToScreen = listOfErrorsToScreen + value.rawValue + "\n"
                }
                print("список ошибок - \(listOfErrorsToScreen)")
            }
        }
    }
    return listOfErrorsToScreen
}

private func changeTextFieldColorAndText(_ textField: UITextField, _ message: String) {
    textField.attributedPlaceholder = NSAttributedString(string: message, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder(textField), attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray])
    })
}

public func alertMessageOnTextField(_ alert: UILabel, _ message: String) {
    alert.text = message
    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
        alert.text = ""
    })
}

private func checkStatus(_ status: Bool) {
    if statusEntry {
        statusEntry = status
    } else {
        statusEntry = false
    }
}
    
private func shakeMeBaby(_ shakedItem: UITextField) {
    let shake = CABasicAnimation(keyPath: "position")
    let xDelta = CGFloat(3)
    shake.duration = 0.07
    shake.repeatCount = 4
    shake.autoreverses = true

    let from_point = CGPoint(x: shakedItem.center.x - xDelta, y: shakedItem.center.y)
    let from_value = NSValue(cgPoint: from_point)

    let to_point = CGPoint(x: shakedItem.center.x + xDelta, y: shakedItem.center.y)
    let to_value = NSValue(cgPoint: to_point)

    shake.fromValue = from_value
    shake.toValue = to_value
    shake.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    shakedItem.layer.add(shake, forKey: "position")
}


//MARK: ================================== ProfileVC ==================================


//MARK: ================================== MainTabBar =================================

//код для проверки ориентации экрана и изменения видимости статус бара.
public func checkOrientation() {
    if (UIScreen.main.bounds.height > UIScreen.main.bounds.width) {
        UIApplication.shared.statusBarUIView?.isHidden = false
        UIApplication.shared.statusBarUIView?.backgroundColor = .systemGray6
    } else {
        UIApplication.shared.statusBarUIView?.isHidden = true
    }
}

//код для покраски статус бара (заимствован)
extension UIApplication {
var statusBarUIView: UIView? {
    if #available(iOS 13.0, *) {
        let tag = 3848245
        let keyWindow = UIApplication.shared.connectedScenes
            .map({$0 as? UIWindowScene})
            .compactMap({$0})
            .first?.windows.first
        if let statusBar = keyWindow?.viewWithTag(tag) {
            return statusBar
        } else {
            let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
            let statusBarView = UIView(frame: height)
            statusBarView.tag = tag
            statusBarView.layer.zPosition = 999999

            keyWindow?.addSubview(statusBarView)
            return statusBarView
        }
    } else {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
    }
    return nil
  }
}
