
import UIKit

class FeedViewController: UIViewController {
    
    struct Post {
        var title: String
    }
    
      
//MARK: - ITEMs
    private let newPost = Post(title: "Post")
    
    private let feedStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var feedButton1: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = .systemBlue
        button.setTitle("New Post", for: .normal)
        button.setTitle("Post opening...", for: .highlighted)
        button.addTarget(self, action: #selector(tapFeedButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var feedButton2: CustomButton = {
        let button = CustomButton()
        button.backgroundColor = .systemBlue
        button.setTitle("New Post!!!", for: .normal)
        button.setTitle("Post opening...", for: .highlighted)
        button.addTarget(self, action: #selector(tapFeedButton), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - INITs
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            showDefaultItems()
        }
        
        override func viewWillLayoutSubviews() {
            checkOrientation()
        }

//MARK: - METHODs
    @objc private func tapFeedButton() {
        let thirdVC = PostViewController()
        thirdVC.post = newPost
        navigationController?.pushViewController(thirdVC, animated: true)
    }
    
    private func showDefaultItems() {
        view.addSubview(feedStackView)
        [feedButton1, feedButton2].forEach { feedStackView.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            feedStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            feedStackView.widthAnchor.constraint(equalToConstant: screenWidth),
            feedStackView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
}

