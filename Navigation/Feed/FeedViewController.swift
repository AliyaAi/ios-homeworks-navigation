//
//  FeedViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//

import UIKit

class FeedViewController: UIViewController {

    private var verticalStack: UIStackView = {
        var stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var firstButton: UIButton = {
        let fButton = UIButton()
        fButton.setTitle("Показать пост", for: .normal)
        fButton.setTitleColor(UIColor(red: 120/255, green: 40/255, blue: 63/255, alpha: 1), for: .normal)
        fButton.backgroundColor = .white
        fButton.layer.cornerRadius = 12
        fButton.clipsToBounds = true
        fButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        fButton.translatesAutoresizingMaskIntoConstraints = false
        return fButton
    }()

    private var secondButton: UIButton = {
        let sButton = UIButton()
        sButton.setTitle("Показать пост", for: .normal)
        sButton.setTitleColor(UIColor(red: 120/255, green: 40/255, blue: 63/255, alpha: 1), for: .normal)
        sButton.backgroundColor = .white
        sButton.layer.cornerRadius = 12
        sButton.clipsToBounds = true
        sButton.addTarget(self, action: #selector(didTapPostButton), for: .touchUpInside)
        sButton.translatesAutoresizingMaskIntoConstraints = false
        return sButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Лента"
        self.navigationItem.backButtonTitle = ""
        self.view.addSubview(self.verticalStack)
        self.verticalStack.addArrangedSubview(self.firstButton)
        self.verticalStack.addArrangedSubview(self.secondButton)
        self.setupView()
    }

    private func setupView() {
        self.view.backgroundColor = UIColor(red: 120/255, green: 255/255, blue: 210/255, alpha: 1)

        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: verticalStack, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 1),
            NSLayoutConstraint(item: verticalStack, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 1),
            self.firstButton.heightAnchor.constraint(equalToConstant: 80),
            self.firstButton.widthAnchor.constraint(equalToConstant: 200),
            self.secondButton.heightAnchor.constraint(equalToConstant: 80),
            self.secondButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    @objc private func didTapPostButton() {
        let postVC = PostViewController()
        postVC.closure = {
        }
        self.navigationController?.pushViewController(postVC, animated: true)
    }

}

