//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//
import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var setTitleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set title", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(didTapSetTitleButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "ArticleCell")
        tableView.backgroundColor = .clear
        tableView.backgroundColor = .systemGray6
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 0.5
        return tableView
    }()
    
    private var headerHeight: CGFloat = 220
    
    private var dataSource: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleButtonSetup()
        setupTableView()
        addDataSource()
    }
    
    private func setTitleButtonSetup() {
        self.view.addSubview(setTitleButton)
        
        let setTitleButtonHeightConstraint = self.setTitleButton.heightAnchor.constraint(equalToConstant: 50)
        let setTitleButtonBottomConstraint = self.setTitleButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        let setTitleButtonLeadingConstraint = self.setTitleButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
        let setTitleButtonTrailingConstraint = self.setTitleButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        
        NSLayoutConstraint.activate([
            setTitleButtonHeightConstraint,
            setTitleButtonBottomConstraint,
            setTitleButtonLeadingConstraint,
            setTitleButtonTrailingConstraint
        ])
    }
    
    private func setupTableView() {
        self.view.addSubview(self.tableView)
        
        let tableViewTopConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let tableViewBottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.setTitleButton.topAnchor)
        let tableViewLeadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10)
        let tableViewTrailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        
        NSLayoutConstraint.activate([
            tableViewTopConstraint,
            tableViewBottomConstraint,
            tableViewLeadingConstraint,
            tableViewTrailingConstraint
        ])

    }
    
    private func addDataSource() {
        self.dataSource.append(.init(author: "Zendaya",  description: "Hello", image: "zendaya1", likes: 25, views: 30))
        self.dataSource.append(.init(author: "Zendaya", description: "Hello", image: "zendaya2", likes: 23, views: 28))
        self.dataSource.append(.init(author: "Zendaya", description: "!!!", image: "zendaya3", likes: 15, views: 18))
        self.dataSource.append(.init(author: "Zendaya",  description: "Hello", image: "zendaya4", likes: 25, views: 30))
    }
    
    @objc func didTapSetTitleButton() {
        let ac = UIAlertController(title: "Set title", message: "Enter new title", preferredStyle: .alert)
        ac.addTextField()
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self, weak ac] _ in
            guard let newTitle = ac?.textFields?[0].text else {return}
            if newTitle.isEmpty {
                let ac = UIAlertController(title: "You should enter something", message: nil, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                ac.addAction(okAction)
                self?.present(ac, animated: true)
            }
            self?.profileHeaderView.changeTitle(title: newTitle)
        }
        ac.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        present(ac, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        let article = self.dataSource[indexPath.row]
        let viewModel = PostTableViewCell.ViewModel(author: article.author,
                                                    image: article.image,
                                                    description: article.description,
                                                    likes: article.likes,
                                                    views: article.views)
        cell.setup(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView()
        if section == 0 {
            headerView = ProfileHeaderView()
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  headerHeight
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {
    
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.headerHeight = textFieldIsVisible ? 220 : 265
        UIView.animate(withDuration: 0.3, delay: 0.1) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
        self.tableView.reloadData()
    }
}


