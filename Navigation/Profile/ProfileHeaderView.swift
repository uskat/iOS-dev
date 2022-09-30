import SnapKit
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
    
    let profileImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = sizeProfileImage / 2
        $0.layer.borderWidth = 3
        $0.layer.borderColor = UIColor.white.cgColor
        $0.contentMode = .scaleAspectFill        //полное заполнение
        $0.image = UIImage(named: "obiwan")
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        return $0
    }(UIImageView())
    
    //======================================================================================================
    let buttonX: UIButton = {
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

    private let profileLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.text = "Obi Wan Kenobi"
        $0.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        return $0
    }(UILabel())

    private lazy var mainButton: CustomButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 4
        $0.backgroundColor = .systemBlue
        $0.setTitle("Set status", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle("Status is being recorded", for: .highlighted)
        $0.addTarget(self, action: #selector(tapMainButton), for: .touchUpInside)
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 4
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.7
        return $0
    }(CustomButton())
    
    let profileStatus: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = UIColor.darkGray
        $0.text = "Waiting for something....."
        $0.backgroundColor = UIColor(displayP3Red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        return $0
    }(UILabel())

    lazy var editStatus: UITextField = {
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Type new status"          //текстовая подсказка в поле textField
        $0.adjustsFontSizeToFitWidth = true         //уменьшение шрифта, если введенный текст не помещается
        $0.minimumFontSize = 10                     //до какого значения уменьшается шрифт
        $0.tag = 3
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.tintColor = UIColor.AccentColor.normal                          //цвет курсора
        $0.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0) //сдвиг курсора на 5пт в textField (для красоты)
        $0.addTarget(self, action: #selector(beginToEditStatus), for: .allEditingEvents)
        $0.addTarget(self, action: #selector(changeStatusText), for: .editingChanged)
        $0.addTarget(self, action: #selector(endToEditStatus), for: .editingDidEnd)
        return $0
    }(UITextField())
    
    private lazy var statusAlert: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = ""
        $0.textColor = .systemRed
        $0.textAlignment = .right
        $0.font = UIFont.systemFont(ofSize: 13, weight: .light)
        return $0
    }(UILabel())

    private lazy var buttonAccept: CustomButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 9
        $0.backgroundColor = .systemBlue
        $0.setImage(UIImage(systemName: "checkmark.rectangle.portrait"), for: .normal)
        $0.tintColor = .white
        $0.isHidden = true
        $0.addTarget(self, action: #selector(tapAcceptStatusButton), for: .touchUpInside)
        return $0
    }(CustomButton())
    
    
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
        
        profileLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(27)
            make.leading.equalTo(safeAreaLayoutGuide).offset(sizeProfileImage + 2 * space)
        }
        
        mainButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(sizeProfileImage + 2 * space)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(space)
            make.height.equalTo(50)
        }
        
        profileStatus.snp.makeConstraints { make in
            make.bottom.equalTo(mainButton).offset(-space - 46 - 50)
            make.leading.equalTo(safeAreaLayoutGuide).offset(sizeProfileImage + 2 * space)
        }
        
        editStatus.snp.makeConstraints { make in
            make.bottom.equalTo(mainButton).offset(-space / 2 - 6 - 50)
            make.leading.equalTo(safeAreaLayoutGuide).offset(sizeProfileImage + 2 * space)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-space)
            make.height.equalTo(40)
        }
        
        buttonAccept.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.top.equalTo(editStatus).offset(5)
            make.trailing.equalTo(editStatus).offset(-5)
        }
       
        [viewUnderImage, profileImage, buttonX].forEach { self.addSubview($0) }
        viewUnderImage.addSubview(blurBackgroundEffect())

        viewUnderImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(screenHeight)
        }

        buttonX.snp.makeConstraints { make in
            make.top.equalTo(viewUnderImage).offset(20)
            make.trailing.equalTo(viewUnderImage).offset(-20)
            make.height.width.equalTo(24)
        }
        
        topProfileImage = profileImage.topAnchor.constraint(equalTo: viewUnderImage.topAnchor, constant: space)
        leadingProfileImage = profileImage.leadingAnchor.constraint(equalTo: viewUnderImage.leadingAnchor, constant: space)
        widthProfileImage = profileImage.widthAnchor.constraint(equalToConstant: sizeProfileImage)
        heightProfileImage = profileImage.heightAnchor.constraint(equalToConstant: sizeProfileImage)
        
        NSLayoutConstraint.activate([
            topProfileImage, leadingProfileImage, widthProfileImage, heightProfileImage
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
        print("tapGesture?")
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
