
import UIKit

class LogInViewController: UIViewController {

    let loginViewModel: LoginViewModel
    let viewModel: ProfileViewModel
    let coordinator: ProfileCoordinator
    var loginDelegate: LoginViewControllerDelegate?
    private let notification = NotificationCenter.default ///уведомление для того чтобы отслеживать перекрытие клавиатурой UITextField
    
//MARK: - ITEMs
    private let scrollLoginView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .white
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let logoItem: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "logo")
        return $0
    }(UIImageView())
    
    private let stackLogin: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 0.5
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.backgroundColor = .systemGray6
        $0.clipsToBounds = true
        return $0
    }(UIStackView())

    private lazy var login: UITextField = {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Login"
        $0.tag = 1
        $0.delegate = self
        $0.textColor = .black
        $0.tintColor = UIColor.AccentColor.normal                           ///цвет курсора
        $0.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)  ///сдвиг курсора на 5пт в textField (для красоты)
        $0.autocapitalizationType = .none
        $0.backgroundColor = .systemGray6
        return $0
    }(UITextField())
   
    private lazy var loginAlert: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .systemRed
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return $0
    }(UILabel())
    
    private lazy var loginView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 0.5
        $0.backgroundColor = .systemGray6
        return $0
    }(UIView())
    
    private lazy var pass: UITextField = {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Password"
        $0.tag = 2
        $0.delegate = self
        $0.textColor = .black
        $0.tintColor = UIColor.AccentColor.normal                           ///цвет курсора
        $0.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0)  ///сдвиг курсора на 5пт в textField (для красоты)
        $0.backgroundColor = .systemGray6
        $0.isSecureTextEntry = true
        return $0
    }(UITextField())
    
    private lazy var passAlert: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .systemRed
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return $0
    }(UILabel())

    private lazy var loginButton: CustomButton = {
        $0.layer.cornerRadius = 10
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 4
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.7
        return $0
    }(CustomButton(title: "Log in",
                   background: UIColor.AccentColor.normal,
                   tapAction:  { [weak self] in self?.tapLoginButton() }))
    
    var errorsLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        $0.textColor = .systemRed
        $0.alpha = 0.30
        $0.numberOfLines = 9
        return $0
    }(UILabel())
    
    private var hackersList: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        $0.textColor = .systemRed
        $0.alpha = 0.0
        $0.numberOfLines = 6
        $0.text = """
        Добрые хакеры взломали все пароли...
        Только никому ни слова, тссс
        login: 11@ru.ru  || pass: 111111
        login: 22@ru.ru || pass: 222222
        login: 33@ru.ru || pass: 333333
        login: 44@ru.ru || pass: 444444
        """
        return $0
    }(UILabel())
    
    
//MARK: - INITs
    init(loginViewModel: LoginViewModel, viewModel: ProfileViewModel, coordinator: ProfileCoordinator) {
        self.loginViewModel = loginViewModel
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        showLoginItems()
        view.addTapGestureToHideKeyboard() ///скрываем клавиатуру при нажатии вне поля textField
        #if DEBUG
            login.text = "22@ru.ru"
            pass.text = "222222"
        #else
            login.text = "44@ru.ru"
            pass.text = "444444"
        #endif
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true ///прячем NavigationBar
        notification.addObserver(self, selector: #selector(keyboardAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        notification.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
        
    override func viewDidAppear(_ animated: Bool) {
        login.animate(newText: placeHolder(login), characterDelay: 0.2)
        pass.animate(newText: placeHolder(pass), characterDelay: 0.2)
    }
    
    
//MARK: - METHODs
    @objc private func keyboardAppear(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollLoginView.contentInset.bottom = keyboardSize.height + 80
            scrollLoginView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            hackersList.alpha = 1.0
        }
    }
    
    @objc private func keyboardDisappear() {
        scrollLoginView.contentInset = .zero
        scrollLoginView.verticalScrollIndicatorInsets = .zero
        hackersList.alpha = 0.0
    }
        
    private func tapLoginButton() {
        loginViewModel.statusEntry = true
        
        checkInputedData(login, loginAlert)
        UIView.animate(withDuration: 4.5, delay: 0.0, options: .curveEaseOut) { [self] in
            errorsLabel.text = validateEmail(login)
            errorsLabel.alpha = 1.0
            view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn) { [self] in
                errorsLabel.text = ""
                errorsLabel.alpha = 0.0
                view.layoutIfNeeded()
            } completion: { _ in  }
        }
        
        checkInputedData(pass, passAlert)
        
        if loginViewModel.statusEntry {
            print("statusEntry = \(loginViewModel.statusEntry)")
            if let login = login.text, let pass = pass.text {
                print("* LoginVC(1). login/pass nil-check. login = \(login), pass = \(pass), loginDelegate = \(loginDelegate)")
                if let loginDelegate = loginDelegate?.check(login: login, pass: pass, user: viewModel.userService.checkUser(login)) {
                    print("* LoginVC(2). loginDelegate = \(loginDelegate)")
                    if loginDelegate {
                        let profileVC = ProfileViewController(viewModel: viewModel, coordinator: coordinator)
                        viewModel.user = viewModel.userService.checkUser(login)
                        navigationController?.pushViewController(profileVC, animated: true)
                        self.login.text = ""
                        self.pass.text = ""
                    } else {
                        alertOfIncorrectLoginOrPass()
                    }
                } else { print("* LoginVC(2else). loginDelegate = \(loginDelegate)") }
            } else { print("* LoginVC(1else). login/pass nil-check. login = \(login), pass = \(pass)") }
        } else { print("* LoginVC. false statusEntry")}
    }

    private func alertOfIncorrectLoginOrPass() {
        let alert = UIAlertController(title: "Incorrect Login or Password", message: "please check your input", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Try again", style: .destructive) {
            _ in print("Отмена")
        }
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func validateEmail(_ textField: UITextField) -> String {
        var listOfErrorsToScreen = """
        """
        if textField.tag == 1 {
            if let email = textField.text {
                let validator = EmailValidator(email: email)
                print("Validator checked")
                if !validator.checkDomain() {
                    for (_, value) in validator.errors.enumerated() {
                        listOfErrorsToScreen = listOfErrorsToScreen + value.rawValue + "\n"
                    }
                    print("Cписок ошибок - \(listOfErrorsToScreen)")
                }
            }
        }
        return listOfErrorsToScreen
    }
        
    private func showLoginItems() {
        view.addSubview(scrollLoginView)
        
        NSLayoutConstraint.activate([
            scrollLoginView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollLoginView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollLoginView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollLoginView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        scrollLoginView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollLoginView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollLoginView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollLoginView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollLoginView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollLoginView.widthAnchor)
        ])
        
        [logoItem, stackLogin, loginButton, errorsLabel, hackersList].forEach({ contentView.addSubview($0) })
        loginView.addSubview(login)
        [loginView, pass].forEach({ stackLogin.addArrangedSubview($0) })
        [loginAlert, passAlert].forEach({ contentView.addSubview($0) })
        
        NSLayoutConstraint.activate([
            logoItem.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 120),
            logoItem.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoItem.widthAnchor.constraint(equalToConstant: 100),
            logoItem.heightAnchor.constraint(equalToConstant: 100),
            
            login.topAnchor.constraint(equalTo: loginView.topAnchor),
            login.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            login.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            login.bottomAnchor.constraint(equalTo: loginView.bottomAnchor),

            stackLogin.topAnchor.constraint(equalTo: logoItem.bottomAnchor, constant: 120),
            stackLogin.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackLogin.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackLogin.heightAnchor.constraint(equalToConstant: 100),

            loginButton.topAnchor.constraint(equalTo: stackLogin.bottomAnchor, constant: 16),
            loginButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            //loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            errorsLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            errorsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            errorsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            errorsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            hackersList.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hackersList.bottomAnchor.constraint(equalTo: stackLogin.topAnchor, constant: -8),
            
            loginAlert.centerYAnchor.constraint(equalTo: login.centerYAnchor),
            loginAlert.trailingAnchor.constraint(equalTo: login.trailingAnchor, constant: -5),
            loginAlert.widthAnchor.constraint(equalToConstant: 220),
            
            passAlert.centerYAnchor.constraint(equalTo: pass.centerYAnchor),
            passAlert.trailingAnchor.constraint(equalTo: pass.trailingAnchor, constant: -5),
            passAlert.widthAnchor.constraint(equalToConstant: 220)
        ])
    }
}

//MARK: убираем клавиатуру по нажатию Enter (Return)
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
