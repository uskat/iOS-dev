
import UIKit
import AVFoundation
import iOSIntPackage

protocol AddLikeDelegate: AnyObject {
    func addLike(_ index: IndexPath, _ from: String)
}

class ProfileViewController: UIViewController, AddLikeDelegate {

    private let profileHeaderView = ProfileHeaderView()
    private let profileTVCell = ProfileTableViewCell()
    private let detailedPostVC = DetailedPostViewController()
    private let photosVC = PhotosViewController()
    
    
//MARK: - ITEMs
   
    //MARK: bottom part of ProfileView

    private lazy var tableView: UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = .clear
        $0.dataSource = self
        $0.delegate = self
        $0.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        $0.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    
//MARK: - INITs
        override func viewDidLoad() {
            super.viewDidLoad()
            //self.navigationController?.isNavigationBarHidden = true
            showProfileTable()
            #if DEBUG
                tableView.backgroundColor = .white
            #else
                tableView.backgroundColor = .systemYellow
            #endif
        }
        
        override func viewWillLayoutSubviews() {
            self.navigationController?.isNavigationBarHidden = true
            checkOrientation()
        }
        
        override func viewDidAppear(_ animated: Bool) {
            //в extension UITextField дописана функция анимации
            profileHeaderView.editStatus.animate(newText: placeHolder(profileHeaderView.editStatus), characterDelay: 0.2)
        }

    
//MARK: - METHODs
    
    private func showProfileTable() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func addLike(_ index: IndexPath, _ from: String) { //vars: "Profile", "Detail"
        print("tapLike addLike! ", terminator: "")
        print("количество лайков ДО = \(posts[index.row - 1].likes),", terminator: " ")
        posts[index.row - 1].likes += 1
        switch from {
        case "Detail":  detailedPostVC.delegate = self
                        detailedPostVC.post = posts[index.row - 1]
        case "Profile": profileTVCell.delegate = self
                        profileTVCell.post = posts[index.row - 1]
        default:        print("")
        }
        print("количество лайков ПОСЛЕ = \(posts[index.row - 1].likes)")
        tableView.reloadData()
    }
}


//MARK: UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.identifier, for: indexPath) as! PhotosTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
            cell.setupCell(posts[indexPath.row - 1])
            cell.index = indexPath
            cell.delegate = self
        
            return cell
        }
    }
}

//MARK: высота ячейки в таблице.
//Либо фиксированное значение, либо авто - UITableView.automaticDimension
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
//MARK: устанавливаем HEADER для таблицы !
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileHeaderView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        240
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            //navigationController?.pushViewController(post, animated: true)
            
            //анимированный push-переход с эффектом fade из Photos в Photo Galery
            let transition = CATransition()
            transition.duration = 2.0
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            transition.subtype = CATransitionSubtype.fromTop
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.pushViewController(photosVC, animated: false)
        } else {
            detailedPostVC.index = indexPath
            profileTVCell.index = indexPath
            detailedPostVC.delegate = self
            posts[indexPath.row - 1].views += 1
            present(detailedPostVC, animated: true)
            detailedPostVC.setupCell(posts[indexPath.row - 1])
            tableView.reloadData()
        }
    }
}
