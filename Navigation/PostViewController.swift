//
//  PostViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 21.02.2022.
//

import UIKit

class PostViewController: UIViewController {
    var postInfo: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        setupPostInfoButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard postInfo != nil, let postTitle = postInfo?.title else { return }
        navigationItem.title = postTitle
    }
    
    private func setupPostInfoButton() {
        let button = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(showPostInfo))
        
        navigationItem.setRightBarButton(button, animated: true)
    }
    
    @objc private func showPostInfo(_ sender: UIBarButtonItem) {
        present(InfoViewController(), animated: true)
    }
}
