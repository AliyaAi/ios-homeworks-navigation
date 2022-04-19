//
//  InfoViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//
import UIKit

class InfoViewController: UIViewController {




    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        let alertButton = UIButton(type: .system) as UIButton
        alertButton.layer.cornerRadius = 12
        alertButton.clipsToBounds = true
        alertButton.backgroundColor = .purple
        alertButton.setTitle("Alert!", for: .normal)
        alertButton.setTitleColor(.systemPurple, for: .normal)
        alertButton.addTarget(self, action: #selector(makeAlert), for: .touchUpInside)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(alertButton)
        alertButton.bottomAnchor.constraint(equalTo: self.view.lastBaselineAnchor, constant: -40).isActive = true
        alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        alertButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func setupView() {
        self.view.backgroundColor = .systemPink

    }
    @objc func makeAlert(sender:UIButton?)  {
        let alertController = UIAlertController(title: "ALERT!",
                                                message: "ALERT MESSAGE",
                                                preferredStyle: .alert)
        //ok
        let actionOK = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: {(action:UIAlertAction!) in
            print("OK Was pressed!")
        })
        //cancel
        let actionCancel = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: {(action:UIAlertAction!) in
            print("Cancel was pressed!")
        })
        //adding all these buttons
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        
        self.present(alertController, animated: true, completion: nil)

    }
}

