//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    var closure: (() -> Void)?

    private lazy var detailView: DetailedPostView = {
        let detailView = DetailedPostView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        return detailView
    }()

    private lazy var transparentView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var crossButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.alpha = 0
        button.addTarget(self, action: #selector(didTapCross), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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

    private let avatarView = ProfileHeaderView()
    private let tapGestureRecognizer = UITapGestureRecognizer()
    private var dataSourcePost = posts
    private var isLikedPost = false
    private var row = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.transparentView)
        self.view.bringSubviewToFront(self.transparentView)
        self.transparentView.addSubview(self.avatarView.avatarImageView)
        self.transparentView.addSubview(self.crossButton)
        self.setupView()
    }

    private func setupView() {
        self.view.backgroundColor = .white

        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.transparentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.transparentView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.transparentView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.transparentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            self.crossButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.crossButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }

    @objc private func didTapCross() {
        UIView.animate(withDuration: 0.3) {
            self.crossButton.alpha = 0
            self.view.layoutIfNeeded()
        }

        UIView.animate(withDuration: 0.5, delay: 0.3) {
            NSLayoutConstraint.deactivate([self.avatarView.avatarWidth, self.avatarView.avatarCenterX, self.avatarView.avatarCenterY].compactMap( { $0 }))

            self.avatarView.avatarWidth = self.avatarView.avatarImageView.widthAnchor.constraint(equalToConstant: 122)
            self.avatarView.avatarCenterX = self.avatarView.avatarImageView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 77)
            self.avatarView.avatarCenterY = self.avatarView.avatarImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 77)

            NSLayoutConstraint.activate([self.avatarView.avatarWidth, self.avatarView.avatarCenterX, self.avatarView.avatarCenterY].compactMap( { $0 }))

            self.avatarView.avatarImageView.layer.cornerRadius = self.avatarView.avatarImageView.frame.height / 2
            self.transparentView.alpha  = 0
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
        headerView.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
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
        self.avatarView.avatarImageView.layer.cornerRadius = self.avatarView.avatarImageView.frame.height / 2

        UIView.animate(withDuration: 0.5) {
            self.transparentView.alpha  = 1.0
            self.avatarView.avatarImageView.layer.cornerRadius = 0

            NSLayoutConstraint.deactivate([self.avatarView.avatarTopConstraint, self.avatarView.avatarLeadingConstraint, self.avatarView.avatarWidth, self.avatarView.avatarCenterX, self.avatarView.avatarCenterY].compactMap( { $0 }))

            self.avatarView.avatarWidth = self.avatarView.avatarImageView.widthAnchor.constraint(equalTo: self.transparentView.widthAnchor)
            self.avatarView.avatarCenterX = self.avatarView.avatarImageView.centerXAnchor.constraint(equalTo: self.transparentView.centerXAnchor)
            self.avatarView.avatarCenterY = self.avatarView.avatarImageView.centerYAnchor.constraint(equalTo: self.transparentView.centerYAnchor)
            NSLayoutConstraint.activate([self.avatarView.avatarWidth, self.avatarView.avatarCenterX, self.avatarView.avatarCenterY].compactMap( { $0 }))

            self.view.layoutIfNeeded()
        }

        UIView.animate(withDuration: 0.3, delay: 0.5) {
            self.crossButton.alpha = 1
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


