//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//

import UIKit

struct Post {
    let author: String
    let description: String
    let image: String
    var likes: Int
    var views: Int
    var isLiked: Bool
}
private var posts: [Post] = [Post.init(author: "Zendaya", description: "Hello", image: "1", likes: 1060, views: 190, isLiked: false),
                             Post.init(author: "Zendaya", description: "!!!", image: "2", likes: 1500, views: 1780, isLiked: false),
                             Post.init(author: "Zendaya", description: "CHEERS!", image: "3", likes: 1080, views: 1980, isLiked: false),
                             Post.init(author: "Zendaya", description: "!!!", image: "4", likes: 1040, views: 1890, isLiked: false),
                             Post.init(author: "Zendaya", description: "!!!", image: "5", likes: 1030, views: 1980, isLiked: false)]

class ProfileViewController: UIViewController {
    
    var closure: (() -> Void)?
    
    private lazy var detailView: DetailedPostView = {
        let detailView = DetailedPostView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        return detailView
    }()
    
    private lazy var view1: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "Header0")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var button1: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.alpha = 0
        button.addTarget(self, action: #selector(tapCross), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let avatar = ProfileHeaderView()
    private let tapGestureRecognizer = UITapGestureRecognizer()
    private var dataSourcePost = posts
    private var isLikedPost = false
    private var row = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.view1)
        self.view.bringSubviewToFront(self.view1)
        self.view1.addSubview(self.avatar.avatarView)
        self.view1.addSubview(self.button1)
        self.setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.view1.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.view1.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.view1.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.view1.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.button1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.button1.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    @objc private func tapCross() {
        UIView.animate(withDuration: 0.3) {
            self.button1.alpha = 0
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3) {
            NSLayoutConstraint.deactivate([self.avatar.avatarWidth, self.avatar.avatarCenterX, self.avatar.avatarCenterY].compactMap( { $0 }))
            
            self.avatar.avatarWidth = self.avatar.avatarView.widthAnchor.constraint(equalToConstant: 122)
            self.avatar.avatarCenterX = self.avatar.avatarView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 77)
            self.avatar.avatarCenterY = self.avatar.avatarView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 77)
            
            NSLayoutConstraint.activate([self.avatar.avatarWidth, self.avatar.avatarCenterX, self.avatar.avatarCenterY].compactMap( { $0 }))
            
            self.avatar.avatarView.layer.cornerRadius = self.avatar.avatarView.frame.height / 2
            self.view1.alpha  = 0
            self.view.layoutIfNeeded()
        }
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate, TapLikedDelegate, TapImagePostDelegate, TapLikedPostDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.dataSourcePost.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath) as! PhotosTableViewCell
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                return cell
            }
            cell.likeDelegate = self
            cell.postDelegate = self
            
            let post = self.dataSourcePost[indexPath.row]
            let viewModel = PostTableViewCell.ViewModel(author: post.author, description: post.description, image: post.image, likes: post.likes, views: post.views)
            cell.setup(with: viewModel)
            
            cell.likesLabel.textColor = self.dataSourcePost[indexPath.row].isLiked ? .systemPink : .black
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header0") as! ProfileHeaderView
        self.tapGestureRecognizer.addTarget(self, action: #selector(handleTapGesture(_:)))
        headerView.avatarView.addGestureRecognizer(tapGestureRecognizer)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 220
        } else {
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            self.didTapPhotoCell()
        } else {}
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == 1 {
            let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, complete in
                self.dataSourcePost.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        } else { return nil }
    }
    
    @objc func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        guard tapGestureRecognizer === gestureRecognizer else { return }
        self.avatar.avatarView.layer.cornerRadius = self.avatar.avatarView.frame.height / 2
        
        UIView.animate(withDuration: 0.5) {
            self.view1.alpha  = 1.0
            self.avatar.avatarView.layer.cornerRadius = 0
            
            NSLayoutConstraint.deactivate([self.avatar.avatarTopConstraint, self.avatar.avatarLeadingConstraint, self.avatar.avatarWidth, self.avatar.avatarCenterX, self.avatar.avatarCenterY].compactMap( { $0 }))
            
            self.avatar.avatarWidth = self.avatar.avatarView.widthAnchor.constraint(equalTo: self.view1.widthAnchor)
            self.avatar.avatarCenterX = self.avatar.avatarView.centerXAnchor.constraint(equalTo: self.view1.centerXAnchor)
            self.avatar.avatarCenterY = self.avatar.avatarView.centerYAnchor.constraint(equalTo: self.view1.centerYAnchor)
            NSLayoutConstraint.activate([self.avatar.avatarWidth, self.avatar.avatarCenterX, self.avatar.avatarCenterY].compactMap( { $0 }))
            
            self.view.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.button1.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func didTapPhotoCell() {
        let photoVC = PhotosViewController()
        photoVC.closure = {
        }
        self.navigationController?.pushViewController(photoVC, animated: true)
    }
    
    func updateLike(indexRow: Int ) {  // лайк можно установить, можно снять
        if self.dataSourcePost[indexRow].isLiked {
            self.dataSourcePost[indexRow].likes -= 1
        } else {
            self.dataSourcePost[indexRow].likes += 1
        }
        self.dataSourcePost[indexRow].isLiked.toggle()
        self.tableView.reloadData()
    }
    
    func enlargePost(indexRow: Int) {
        self.dataSourcePost[indexRow].views += 1
        self.row = indexRow
        self.tableView.reloadData()
        
        self.view.addSubview(self.detailView)
        self.view.bringSubviewToFront(self.detailView)
        self.detailView.likePostDelegate = self
        
        NSLayoutConstraint.activate([
            self.detailView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.detailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.detailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        self.detailView.authorLabel.text = dataSourcePost[indexRow].author
        self.detailView.postImageView.image = UIImage(named: dataSourcePost[indexRow].image)
        self.detailView.descriptionLabel.text = dataSourcePost[indexRow].description
        self.detailView.likesLabel.text = "Likes: " + String(dataSourcePost[indexRow].likes)
        self.detailView.viewsLabel.text = "Views: " + String(dataSourcePost[indexRow].views)
        self.isLikedPost = dataSourcePost[indexRow].isLiked
        
        self.detailView.likesLabel.textColor = self.isLikedPost ? .systemPink : .black
        
        self.detailView.isHidden = false
    }
    
    func updateLikePost() {
        if self.dataSourcePost[row].isLiked {
            self.dataSourcePost[row].likes -= 1
        } else {
            self.dataSourcePost[row].likes += 1
        }
        self.dataSourcePost[row].isLiked.toggle()
        
        self.detailView.likesLabel.textColor = self.dataSourcePost[row].isLiked ? .systemPink : .black
        self.detailView.likesLabel.text = "Likes: " + String(self.dataSourcePost[row].likes)
        
        self.tableView.reloadData()
    }
    
}


