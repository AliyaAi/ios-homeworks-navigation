//

//  TabBarControllerViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .blue
        setupViewControllers()

    }

    func setupViewControllers() {
        viewControllers = [
            createNavigationController(for: FeedViewController(), title: NSLocalizedString("Лента", comment: ""), image: UIImage(systemName: "house")!),
            createNavigationController(for: ProfileViewController(), title: NSLocalizedString("Профиль", comment: ""), image: UIImage(systemName: "person")!)
        ]
    }

    fileprivate func createNavigationController(for rootViewController: UIViewController,
                                                title: String,
                                                image: UIImage) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        navigationController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navigationController
    }
}

