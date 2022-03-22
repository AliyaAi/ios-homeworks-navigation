//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Александр Якубов on 15.03.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapShowStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

final class ProfileHeaderView: UIView {

    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Zendaya"))
        imageView.layer.cornerRadius = 75
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Zendaya"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello!"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var statusTextView1: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray
        textView.font = .systemFont(ofSize: 14)
        textView.textColor = .gray
        textView.text = "Статус"
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Статус", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(self.didTapSetStatusButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Статус"
        textField.delegate = self
        textField.keyboardType = .default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.keyboardAppearance = .default
        textField.autocapitalizationType = .words
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .systemGray2
        textField.backgroundColor = .systemGray4
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        textField.keyboardType = .default
        textField.clearButtonMode = .always
        textField.alpha = 0
        textField.translatesAutoresizingMaskIntoConstraints = false

        return textField
    }()

    private var topSetStatusButtonOn: NSLayoutConstraint?
    private var topSetStatusButtonOff: NSLayoutConstraint?
    weak var delegate: ProfileHeaderViewProtocol?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (touches.first) != nil {
            endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }

    private func drawSelf() {
        self.addSubview(self.avatarImageView)
        self.addSubview(self.fullNameLabel)
        self.addSubview(self.statusLabel)
        self.addSubview(self.statusButton)
        self.addSubview(self.statusTextField)
        let topAvatarImageConstraint = self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingAvatarImageConstraint = self.avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let widthAvatarImageConstraint = self.avatarImageView.widthAnchor.constraint(equalToConstant: 150)
        let heightAvatarImageConstraint = self.avatarImageView.heightAnchor.constraint(equalToConstant: 150)
        let topFullNameLabelConstraint = self.fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let leadingFullNameLabelConstraint = self.fullNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 182)
        let trailingFullNameLabelConstraint = self.fullNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        self.topSetStatusButtonOn = self.statusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16)
        self.topSetStatusButtonOn?.priority = UILayoutPriority(rawValue: 999)
        let leadingSetStatusButton = self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let trailingSetStatusButton = self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let heightSetStatusButton = self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        let bottomStatusLabel = self.statusLabel.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -18)
        let leadingStatusLabel = self.statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor)
        let trailingStatusLabel = self.statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor)
        NSLayoutConstraint.activate([
            topAvatarImageConstraint, leadingAvatarImageConstraint, widthAvatarImageConstraint,
            heightAvatarImageConstraint, topFullNameLabelConstraint, leadingFullNameLabelConstraint,
            trailingFullNameLabelConstraint,
            self.topSetStatusButtonOn, leadingSetStatusButton, trailingSetStatusButton,
            heightSetStatusButton, bottomStatusLabel, leadingStatusLabel, trailingStatusLabel
        ].compactMap({ $0}))
    }

    @objc private func didTapSetStatusButton() {
        if self.statusTextField.isHidden {
            self.statusTextField.alpha = 1
            
            NSLayoutConstraint.deactivate([self.topSetStatusButtonOff].compactMap({ $0 }))
            let topConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 27)
            let leadingConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
            let trailingConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.statusLabel.trailingAnchor)
            let heightStatusTextFieldConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 34)

            self.topSetStatusButtonOn = self.statusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 70)

            NSLayoutConstraint.activate([
                topConstraint, leadingConstraint, trailingConstraint, heightStatusTextFieldConstraint,
                self.topSetStatusButtonOn
            ].compactMap({ $0 }))
            self.statusButton.setTitle("Set status", for: .normal)
        } else {
            self.statusTextField.isHidden = false
            self.statusTextField.alpha = 0
            self.statusButton.setTitle("Show status", for: .normal)
            self.statusTextField.endEditing(true)
            NSLayoutConstraint.deactivate([self.topSetStatusButtonOn].compactMap({ $0 }))
            if self.statusTextField.text != "" {
                self.statusLabel.text = self.statusTextField.text
                self.statusTextField.text = .none

            }
            self.topSetStatusButtonOff = self.statusButton.topAnchor.constraint(equalTo: self.avatarImageView.bottomAnchor, constant: 16)

            NSLayoutConstraint.activate([self.topSetStatusButtonOff].compactMap({ $0 }))
        }
        self.delegate?.didTapShowStatusButton(textFieldIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.statusTextField.resignFirstResponder()
        return true
    }
}

extension ProfileHeaderView: UITextFieldDelegate {



}
