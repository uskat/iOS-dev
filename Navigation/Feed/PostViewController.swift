
import UIKit

class PostViewController: UIViewController {

    var post: FeedViewController.Post?
    
//MARK: - INITs
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        showBarButton()
        if let post = post {
            title = post.title
        }
    }

//MARK: - METHODs
    private func showBarButton() {
        let button = UIBarButtonItem(title: "Info...", style: .plain, target: self, action: #selector(tapAction))
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func tapAction() {
        let forthVC = InfoViewController()
        present(forthVC, animated: true)
    }
}
