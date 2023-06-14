
import UIKit
import AVFoundation
import AVKit

class FeedViewController: UIViewController {
    
//MARK: - ITEMs
    private let viewModel: FeedViewModel
     var colorOfPassCheck: UIColor = .black
//    private let newPost = Post(title: "Post")

    private lazy var headline: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        $0.text = "Input password to check (right pass: 111)"
        return $0
    }(UILabel())

    private lazy var guessTextField: UITextField = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        $0.placeholder = "Input password"           ///текстовая подсказка в поле textField
        $0.adjustsFontSizeToFitWidth = true         ///уменьшение шрифта, если введенный текст не помещается
        $0.minimumFontSize = 10                     ///до какого значения уменьшается шрифт
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.black.cgColor
        $0.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0) ///сдвиг курсора на 5пт в textField (для красоты)
        return $0
    }(UITextField())
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(
            title: "To guess",
            titleHighlighted: "Let's try...",
            titleHighlightedColor: .lightGray,
            tapAction:  { [weak self] in
                            let feedModel = FeedModel()
                            self?.colorOfPassCheck = feedModel.check(word: self?.guessTextField.text ?? "")
                            self?.headline.textColor = self?.colorOfPassCheck
                        })
        button.layer.cornerRadius = 10
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        return button
    }()
    
    private let feedStackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        return $0
    }(UIStackView())
    
    private lazy var feedButton1: CustomButton = {
        let button = CustomButton(
            title: "New Post",
            titleHighlighted: "Post opening......",
            titleColor: .yellow,
            titleHighlightedColor: .lightGray,
            tapAction: { [weak self] in self?.tapFeedButton() })
        return button
    }()
    
    private lazy var feedButton2: CustomButton = {
        let button = CustomButton(
            title: "Open videoplayer",
            titleHighlighted: "video opening...",
            titleColor: .green,
            titleHighlightedColor: .lightGray,
            tapAction: { [weak self] in self?.tapFeedButton2() })
        return button
    }()
    
    //MARK: - INITs
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addTapGestureToHideKeyboard() /// скрываем клавиатуру при нажатии в любом месте экрана вне textField
        showItems()
    }

//MARK: - METHODs
    private func tapFeedButton() {
        viewModel.load(to: .post)
    }
    
    private func tapFeedButton2() {
        // Создаём AVPlayer со ссылкой на видео.
        let player = AVPlayer(url: viewModel.localURL)

        // Создаём AVPlayerViewController и передаём ссылку на плеер.
        let controller = AVPlayerViewController()
        controller.player = player

        // Показываем контроллер модально и запускаем плеер.
        present(controller, animated: true) {
            player.play()
        }
//        viewModel.load(to: .info)
    }
    
    private func showItems() {
        [headline, guessTextField, checkGuessButton, feedStackView].forEach{ view.addSubview($0) }
        [feedButton1, feedButton2].forEach { feedStackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            //заголовок проверки значения
            headline.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            headline.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headline.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            //поле для ввода проверяемого значения
            guessTextField.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 16),
            guessTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            guessTextField.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -16),
            guessTextField.heightAnchor.constraint(equalToConstant: 40),

            //кнопка для запуска проверки значения
            checkGuessButton.topAnchor.constraint(equalTo: headline.bottomAnchor, constant: 16),
            checkGuessButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 16),
            checkGuessButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 40),
            
            feedStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            feedStackView.widthAnchor.constraint(equalToConstant: screenWidth),
            feedStackView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
}
