//
//  PostViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//

import UIKit

class PostViewController: UIViewController {

    var closure: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 222/255, green: 193/255, blue: 210/255, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Пост"
        self.setInfoButton()
    }

    private func setInfoButton() {
        let infoButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(didTapInfoButton))
        self.navigationItem.rightBarButtonItem  = infoButtonItem
    }

    @objc func didTapInfoButton(){
        let infoVC = InfoViewController()
        self.present(infoVC, animated: true, completion: infoVC.closure)
    }

}
