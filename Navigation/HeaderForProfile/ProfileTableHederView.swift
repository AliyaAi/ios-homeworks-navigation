//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Александр Якубов on 20.03.2022.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {

    var avatarImageView: UIImageView = {
        var view = UIImageView()
        view.isUserInteractionEnabled = true
        view.image = UIImage(named: "profileImage")
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var fullNameLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Zendaya"
        return label
    }()

    private var statusLabel: UILabel = {
        var label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello!"
        return label
    }()

    private var setStatusButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(didTapShowStatusButton), for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.setTitle("Set status", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private var statusTextField: UITextField = {
        var textField = UITextField()
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.clipsToBounds = true
        textField.placeholder = "new status"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
    }

    private func setupView() {
        self.addSubview(self.avatarImageView)
        self.addSubview(self.fullNameLabel)
        self.addSubview(self.statusLabel)
        self.addSubview(self.setStatusButton)
        self.addSubview(self.statusTextField)
        self.addConstraints()
    }

    var avatarTopConstraint: NSLayoutConstraint?
    var avatarLeadingConstraint: NSLayoutConstraint?
    var avatarWidth: NSLayoutConstraint?
    var avatarCenterX: NSLayoutConstraint?
    var avatarCenterY: NSLayoutConstraint?

    private func addConstraints() {

        NSLayoutConstraint.activate([
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0),

            self.fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            self.fullNameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 30),

            self.statusLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 30),
            self.statusLabel.bottomAnchor.constraint(equalTo: self.statusTextField.topAnchor, constant: -10),

            self.statusTextField.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 30),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40),
            self.statusTextField.bottomAnchor.constraint(equalTo: self.setStatusButton.topAnchor, constant: -10),

            self.setStatusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16),
            self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 10),
            self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        self.avatarTopConstraint = self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        self.avatarLeadingConstraint = self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        self.avatarWidth = self.avatarImageView.widthAnchor.constraint(equalToConstant: 122)
        self.avatarWidth?.priority = UILayoutPriority(rawValue: 999)
        self.avatarCenterX = self.avatarImageView.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: 77)
        self.avatarCenterX?.priority = UILayoutPriority(rawValue: 999)
        self.avatarCenterY = self.avatarImageView.centerYAnchor.constraint(equalTo: self.topAnchor,constant: 77)
        self.avatarCenterY?.priority = UILayoutPriority(rawValue: 999)
        NSLayoutConstraint.activate([self.avatarTopConstraint, self.avatarLeadingConstraint, self.avatarWidth, self.avatarCenterX, self.avatarCenterY].compactMap({ $0 }))
    }
    @objc private func didTapShowStatusButton() {
        if let text = statusTextField.text {
            if text.isEmpty {
                self.shakeTextField(textField: statusTextField)
            } else {
                self.statusLabel.text = text
            }
            self.statusTextField.text = ""
            self.endEditing(true)
        }
    }

    private func shakeTextField(textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 2, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 2, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
    }
}

