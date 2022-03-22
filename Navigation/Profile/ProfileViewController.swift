//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//

import UIKit

final class ProfileViewController: UIViewController {



    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.backgroundColor = .lightGray

        return view
    }()


    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosTableViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.backgroundColor = .white
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.layer.borderWidth = 0.5
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var heightConstraint: NSLayoutConstraint?

    private var dataSource: [Posts] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupViewTableView()
        self.addPosts()

        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }


    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.isHidden = true

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.lightGray
        navBarAppearance.shadowImage = nil
        navBarAppearance.shadowColor = nil
        self.navigationController?.navigationBar.standardAppearance = navBarAppearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }



    private func setupViewTableView() {
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(self.tableView)

        let topConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let leadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let bottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)


        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
        ])
    }

    private func addPosts() {
            self.dataSource.append(.init(author: "Zendaya",
                                         description: "Hello everyone",
                                         image: "zendaya1",
                                         likes: 1,
                                         views: 1))
            self.dataSource.append(.init(author: "Zendaya",
                                         description: "beautiful",
                                         image: "zendaya2",
                                         likes: 100,
                                         views: 500))
            self.dataSource.append(.init(author: "Zendaya",
                                         description: "Cheers!",
                                         image: "zendaya3",
                                         likes: 45,
                                         views: 65))
            self.dataSource.append(.init(author: "Zendaya",
                                         description: "thanks!",
                                         image: "zendaya4",
                                         likes: 32,
                                         views: 43))
        }

    }

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosTableViewCell", for: indexPath)
            return cell
        } else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? PostTableViewCell else { let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
        return cell
    }
        let article = self.dataSource[indexPath.row - 1]
        let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                             description: article.description,
                                                             image: article.image,
                                                             likes: article.likes,
                                                             views: article.views)
        cell.setup(with: viewModel)
        return cell
    }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView =  profileHeaderView
        headerView.backgroundColor = .lightGray
        headerView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  300
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(PhotosViewController(), animated: true)
            self.navigationItem.backButtonTitle = "Назад"
            title = "Photo"
        } else { return }
    }
    }






