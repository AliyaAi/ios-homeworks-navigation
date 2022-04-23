//
//  PostViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemMint
        let title = "Пост"
        self.navigationItem.title = title
        let infoViewButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(action))
        navigationItem.rightBarButtonItem = infoViewButton
    }
    
    @objc func action(sender:UIBarButtonItem!)  {
        let infoView = InfoViewController()
        self.navigationController?.present(infoView, animated: true, completion: nil)
    }
}
