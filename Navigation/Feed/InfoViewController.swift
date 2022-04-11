//
//  InfoViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//
import UIKit

class InfoViewController: UIViewController {

    var closure: (() -> Void)?

    private lazy var alertButton: UIButton = {
        let alertButton = UIButton()
        alertButton.setTitle("Продолжить", for: .normal)
        alertButton.setTitleColor(UIColor(red: 105/255, green: 40/255, blue: 63/255, alpha: 1), for: .normal)
        alertButton.backgroundColor = .white
        alertButton.layer.cornerRadius = 12
        alertButton.clipsToBounds = true
        alertButton.addTarget(self, action: #selector(didTapAlertButton), for: .touchUpInside)
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        return alertButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.alertButton)
        self.setupView()
    }

    private func setupView() {
        self.view.backgroundColor = UIColor(red: 253/255, green: 221/255, blue: 230/255, alpha: 1)

        NSLayoutConstraint.activate([
            self.alertButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50),
            self.alertButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 60),
            self.alertButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -60),
            self.alertButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func didTapAlertButton() {
        let alert = UIAlertController(title: "Внимание!", message: "Вы уверены, что хотите выполнить действие?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: { (_) in print("\"Отменить\" was selected.") }))
        alert.addAction(UIAlertAction(title: "Подтвердить", style: .default, handler: { (_) in print("\" Подтвердить\" was selected.")}))
        self.present(alert, animated: true, completion: nil)
    }

}
