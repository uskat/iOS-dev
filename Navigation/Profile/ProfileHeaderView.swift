
import UIKit

class ProfileHeaderView: UIView {
    
    let space: CGFloat = 16
    
    //MARK: - ITEMs
    let viewUnderImage: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.alpha = 0.0
        return $0
    }(UIView())
    
    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = sizeProfileImage / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill        //полное заполнение
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    //======================================================================================================
    private lazy var buttonX: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 12
        $0.backgroundColor = UIColor.AccentColor.normal
        $0.setImage(UIImage(systemName: "x.circle"), for: .normal)
        $0.tintColor = .white
        $0.alpha = 0.0
        $0.isHidden = true
        $0.addTarget(self, action: #selector(tapButtonX), for: .touchUpInside)
        return $0
    }(UIButton())
    
    //======================================================================================================

    let profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        return label
    }()

    private lazy var mainButton: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Status is being recorded", for: .highlighted)
        button.addTarget(self, action: #selector(tapMainButton), for: .touchUpInside)
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    let profileStatus: UILabel = {
        let status = UILabel()
        status.translatesAutoresizingMaskIntoConstraints = false
        status.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        status.textColor = UIColor.darkGray
        status.text = "Waiting for something....."
        status.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        return status
    }()

    lazy var editStatus: UITextField = {
        let status = UITextField()
        status.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        status.translatesAutoresizingMaskIntoConstraints = false
        status.placeholder = "Type new status"          //текстовая подсказка в поле textField
        status.adjustsFontSizeToFitWidth = true         //уменьшение шрифта, если введенный текст не помещается
        status.minimumFontSize = 10                     //до какого значения уменьшается шрифт
        status.tag = 3
        status.backgroundColor = .white
        status.layer.cornerRadius = 12
        status.layer.borderWidth = 1
        status.layer.borderColor = UIColor.black.cgColor
        status.tintColor = UIColor.AccentColor.normal                          //цвет курсора
        status.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0) //сдвиг курсора на 5пт в textField (для красоты)
        status.addTarget(self, action: #selector(beginToEditStatus), for: .allEditingEvents)
        status.addTarget(self, action: #selector(changeStatusText), for: .editingChanged)
        status.addTarget(self, action: #selector(endToEditStatus), for: .editingDidEnd)
        return status
    }()
    
    private lazy var statusAlert: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .systemRed
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return $0
    }(UILabel())

    private lazy var buttonAccept: CustomButton = {
        let button = CustomButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 9
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "checkmark.rectangle.portrait"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(tapAcceptStatusButton), for: .touchUpInside)
        return button
    }()
    
    
//MARK: - INITs
    override init(frame: CGRect) {
        super.init(frame: frame)
        showProfileHeaderView()
        tapGestureOnProfileImage()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
//MARK: - METHODs
    @objc private func tapButtonX() {
        print("tap x")
        UIView.animate(withDuration: 1.5, delay: 0.0, options: .curveEaseIn) { [self] in
            topProfileImage.constant = space
            leadingProfileImage.constant = space
            widthProfileImage.constant = sizeProfileImage
            heightProfileImage.constant = sizeProfileImage
            profileImage.layer.cornerRadius = sizeProfileImage / 2
            profileImage.layer.borderWidth = 3
            viewUnderImage.alpha = 0.0
            layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) { [self] in
                buttonX.alpha = 0.0
            } completion: { _ in
                self.buttonX.isHidden = true
            }
        }
    }
    
    @objc private func tapMainButton() {
        statusEntry = true
        checkInputedData(editStatus, statusAlert)
        print("status on Status \(statusEntry)")
        if let oldStatus = profileStatus.text {
            print("Прежний статус (до изменения) - \(oldStatus)")
        }
        profileStatus.text = statusText
        if let newStatus = editStatus.text {
            print("Новый статус - \(newStatus)")
        }
        editStatus.text = ""
        endEditing(true)
        rotateAndSleep(0) //прячем вспомогательную кнопку без анимации
    }
    
    @objc private func beginToEditStatus(_ textField: UITextField) {
        buttonAccept.isHidden = false
    }
    @objc private func changeStatusText(_ textField: UITextField) {
        buttonAccept.isHidden = false
        if let myText = textField.text {
            statusText = myText
        }
    }
    @objc private func endToEditStatus(_ textField: UITextField) {
        rotateAndSleep(0) //прячем вспомогательную кнопку без анимации
    }
    
    @objc private func tapAcceptStatusButton() {
        statusEntry = true
        checkInputedData(editStatus, statusAlert)
        endEditing(true)
        profileStatus.text = statusText
        editStatus.text = ""
        rotateAndSleep(1) //прячем вспомогательную кнопку с анимацией (после нажатия на неё)
    }
    
    func showProfileHeaderView() {
        [profileLabel, mainButton, profileStatus, editStatus, buttonAccept].forEach { self.addSubview($0) }
        
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            profileLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: sizeProfileImage + 2 * space),
            profileLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -space),
            profileLabel.heightAnchor.constraint(equalToConstant: 30),

            mainButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: sizeProfileImage + 2 * space),
            mainButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: space),
            mainButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -space),
            mainButton.heightAnchor.constraint(equalToConstant: 50),

            profileStatus.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -space - 46),
            profileStatus.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: sizeProfileImage + 2 * space),
            profileStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -space),
            profileStatus.heightAnchor.constraint(equalToConstant: 26),

            editStatus.bottomAnchor.constraint(equalTo: mainButton.topAnchor, constant: -space / 2 - 6),
            editStatus.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: sizeProfileImage + 2 * space),
            editStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -space),
            editStatus.heightAnchor.constraint(equalToConstant: 40),

            buttonAccept.topAnchor.constraint(equalTo: editStatus.topAnchor, constant: 5),
            buttonAccept.trailingAnchor.constraint(equalTo: editStatus.trailingAnchor, constant: -5),
            buttonAccept.widthAnchor.constraint(equalToConstant: 30),
            buttonAccept.heightAnchor.constraint(equalToConstant: 30)
        ])
       
        [viewUnderImage, profileImage, buttonX].forEach { self.addSubview($0) }
        viewUnderImage.addSubview(blurBackgroundEffect())
               
        topProfileImage = profileImage.topAnchor.constraint(equalTo: viewUnderImage.topAnchor, constant: space)
        leadingProfileImage = profileImage.leadingAnchor.constraint(equalTo: viewUnderImage.leadingAnchor, constant: space)
        widthProfileImage = profileImage.widthAnchor.constraint(equalToConstant: sizeProfileImage)
        heightProfileImage = profileImage.heightAnchor.constraint(equalToConstant: sizeProfileImage)
        
        NSLayoutConstraint.activate([
            viewUnderImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            viewUnderImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            viewUnderImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            viewUnderImage.heightAnchor.constraint(equalToConstant: screenHeight),
            
            topProfileImage, leadingProfileImage, widthProfileImage, heightProfileImage,
            
            buttonX.topAnchor.constraint(equalTo: viewUnderImage.topAnchor, constant: 20),
            buttonX.trailingAnchor.constraint(equalTo: viewUnderImage.trailingAnchor, constant: -20),
            buttonX.widthAnchor.constraint(equalToConstant: 24),
            buttonX.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    
//MARK: =================================== METHODs ===================================
    private func rotateAndSleep(_ key: Int) {
        if key == 1 { //анимация вращения вокруг своей оси на вспомогательной кнопке
            var perspective = CATransform3DIdentity
            perspective.m34 = 1 / -200
            buttonAccept.imageView!.layer.transform = perspective
            let rotate = CABasicAnimation(keyPath: "transform.rotation.y")
            rotate.fromValue = 0
            rotate.byValue = CGFloat.pi * 2
            rotate.duration = 2
            buttonAccept.imageView!.layer.add(rotate, forKey: nil)
        }
        //скрываем кнопку через 2 секунды (чтобы успела пройти анимация)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: { //задержка выполнения любой команды
            self.buttonAccept.isHidden = true
        })
    }
    
    public var centerXProfileImage = NSLayoutConstraint()
    public var centerYProfileImage = NSLayoutConstraint()
    public var topProfileImage = NSLayoutConstraint()
    public var leadingProfileImage = NSLayoutConstraint()
    public var trailingProfileImage = NSLayoutConstraint()
    public var bottomProfileImage = NSLayoutConstraint()
    public var widthProfileImage = NSLayoutConstraint()
    public var heightProfileImage = NSLayoutConstraint()

    
    //MARK: жесты и анимация
    func tapGestureOnProfileImage() {
        //print("tapGesture?")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnImage))
        profileImage.addGestureRecognizer(tapGesture)
    }

    @objc private func tapOnImage() {
        print("tap")
        UIView.animate(withDuration: 2.5, delay: 0.0, options: .curveEaseOut) { [self] in
            viewUnderImage.addSubview(blurBackgroundEffect())
            if (UIScreen.main.bounds.height > UIScreen.main.bounds.width) {
                topProfileImage.constant = UIScreen.main.bounds.height / 2 - absoluteWidth / 2 - 80
                leadingProfileImage.constant = 0
                trailingProfileImage.constant = 0
            } else {
                topProfileImage.constant = 0
                leadingProfileImage.constant = UIScreen.main.bounds.width / 2 - absoluteWidth / 2
                trailingProfileImage.constant = UIScreen.main.bounds.width / 2 + absoluteWidth / 2
            }
            widthProfileImage.constant = absoluteWidth
            heightProfileImage.constant = absoluteWidth
            profileImage.layer.cornerRadius = 0
            profileImage.layer.borderWidth = 0
            viewUnderImage.alpha = 0.85
            layoutIfNeeded()
            viewUnderImage.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut) { [self] in
                buttonX.isHidden = false
                buttonX.alpha = 1.0
            } completion: { _ in  }
        }
    }
    
    func blurBackgroundEffect() -> UIVisualEffectView {
        //код BlurEffect укороченный без констрейнтов
        let effect = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
        effect.alpha = 0.85
        effect.translatesAutoresizingMaskIntoConstraints = false
        effect.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return effect
    }
}
