//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Александр Якубов on 20.03.2022.
//
import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    var avatarView: UIImageView = {
        var view = UIImageView()
        view.isUserInteractionEnabled = true
        view.image = UIImage(named: "profileImage")
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullName: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Zendaya"
        return label
    }()
    
    private lazy var statusButton: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(didTapstatusButton), for: .touchUpInside)
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
    private lazy var statusLabel: UILabel = {
        var label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello!"
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Type your status here"
        textField.returnKeyType = .done
        textField.autocapitalizationType = .words
        textField.font = .systemFont(ofSize: 15)
        textField.textColor = .systemGray2
        textField.backgroundColor = .systemGray4
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        textField.keyboardType = .default
        textField.clearButtonMode = .always
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
        self.avatarView.layer.cornerRadius = avatarView.frame.height / 2
    }
    
    private func setupView() {
        self.addSubview(self.avatarView)
        self.addSubview(self.fullName)
        self.addSubview(self.statusLabel)
        self.addSubview(self.statusButton)
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
            self.avatarView.heightAnchor.constraint(equalTo: self.avatarView.widthAnchor, multiplier: 1.0),
            
            self.fullName.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
            self.fullName.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 30),
            
            self.statusLabel.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 30),
            self.statusLabel.bottomAnchor.constraint(equalTo: self.statusTextField.topAnchor, constant: -10),
            
            self.statusTextField.leadingAnchor.constraint(equalTo: self.avatarView.trailingAnchor, constant: 30),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40),
            self.statusTextField.bottomAnchor.constraint(equalTo: self.statusButton.topAnchor, constant: -10),
            
            self.statusButton.topAnchor.constraint(equalTo: self.avatarView.bottomAnchor, constant: 16),
            self.statusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 10),
            self.statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        self.avatarTopConstraint = self.avatarView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        self.avatarLeadingConstraint = self.avatarView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        self.avatarWidth = self.avatarView.widthAnchor.constraint(equalToConstant: 122)
        self.avatarWidth?.priority = UILayoutPriority(rawValue: 999)
        self.avatarCenterX = self.avatarView.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: 77)
        self.avatarCenterX?.priority = UILayoutPriority(rawValue: 999)
        self.avatarCenterY = self.avatarView.centerYAnchor.constraint(equalTo: self.topAnchor,constant: 77)
        self.avatarCenterY?.priority = UILayoutPriority(rawValue: 999)
        NSLayoutConstraint.activate([self.avatarTopConstraint, self.avatarLeadingConstraint, self.avatarWidth, self.avatarCenterX, self.avatarCenterY].compactMap({ $0 }))
    }
    
    @objc private func didTapstatusButton() {
        guard let status = statusTextField.text else {return}
        if !status.isEmpty {
            UIView.animate(withDuration: 0.5) {
                self.statusLabel.text = self.statusTextField.text
                self.statusTextField.text = .none
            } completion: { _ in
            }
        }
        if status.isEmpty {
            statusTextField.shake()
        }
        endEditing(true)
    }
    
}





