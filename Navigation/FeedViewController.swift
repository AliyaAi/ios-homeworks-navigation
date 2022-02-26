//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 21.02.2022.
//

import UIKit
struct Post {
    var title: String
}
class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemMint
        let postButton = UIButton(type: .system) as UIButton
        postButton.clipsToBounds = true
        postButton.backgroundColor = .systemPink
        postButton.layer.cornerRadius = 12
        postButton.setTitle("Показать пост", for: .normal)
        postButton.setTitleColor(.black, for: .normal)
        postButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(postButton)
        postButton.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0).isActive = true
        postButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        postButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        postButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        postButton.addTarget(self, action: #selector(makeAction), for: .touchUpInside)

    }

@objc private func makeAction(_ sender: UIButton!) {

    let postVC = PostViewController()
    let postInfo = Post(title: "Пост")
    postVC.postInfo = postInfo
    self.navigationController?.pushViewController(postVC, animated: true)
}
}


