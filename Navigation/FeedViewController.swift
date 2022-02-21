//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 21.02.2022.
//

import UIKit

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemPurple
        let postButton = UIButton(type: .system) as UIButton
        postButton.clipsToBounds = true
        postButton.backgroundColor = .systemBlue
        postButton.layer.cornerRadius = 20
        postButton.setTitle("Post", for: .normal)
        postButton.setTitleColor(.systemPink, for: .normal)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(postButton)
        postButton.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        postButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        postButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        postButton.addTarget(self, action: #selector(makeAction), for: .touchUpInside)

    }
    @objc func makeAction(sender:UIButton!)  {
        let postViewController  = PostViewController()

        self.navigationController?.pushViewController(postViewController, animated: true)

        self.navigationItem.backButtonTitle = "Назад"
    }
}
