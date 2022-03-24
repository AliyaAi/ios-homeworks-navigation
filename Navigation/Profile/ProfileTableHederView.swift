//
//  ProfileTableHederView.swift
//  Navigation
//
//  Created by Александр Якубов on 20.03.2022.
//

import UIKit
import Foundation

protocol ViewModelProtocol {}

protocol Setupable {
    func setup(with viewModel: ViewModelProtocol)
}

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}
class ProfileHeaderView: UIView, UITextFieldDelegate {
        
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Zendaya")
        imageView.layer.cornerRadius = 40
        imageView.layer.borderWidth = 3
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        return imageView
    }()
    
    private lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = titleText
        label.textAlignment = .left
        return label
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = statusText
        return label
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowRadius = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(didTapStatusButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 20
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.isHidden = true
        return textField
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    private var statusText: String = "Hello"
    private var titleText: String = "Zendaya"
    private var setStatusButtonTopConstraint: NSLayoutConstraint?
    private var setStatusButtonBottomConstraint: NSLayoutConstraint?
    
    weak var delegate: ProfileHeaderViewProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.statusTextField.delegate = self
        self.drawSelf()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawSelf(){
        
        self.addSubview(self.infoStackView)
        self.addSubview(self.setStatusButton)
        self.addSubview(self.statusTextField)
        self.infoStackView.addArrangedSubview(self.avatarImageView)
        self.infoStackView.addArrangedSubview(self.labelsStackView)
        self.labelsStackView.addArrangedSubview(self.fullNameLabel)
        self.labelsStackView.addArrangedSubview(self.statusLabel)
        
        let infoStackViewTopConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor)
        let infoStackViewBottomConstraint = self.infoStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -105)
        let infoStackViewLeadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        let infoStackViewTrailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        
        let avatarImageViewAspectRatioConstraint = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
        
        self.setStatusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 10)
        let setStatusButtonLeadingConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let setStatusButtonTrailingConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let setStatusButtonHeightConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
        
        let statusTextFieldTopConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 10)
        let statusTextFieldLeadingConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
        let statusTextFieldTrailingConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
        let statusTextFieldHeightConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 35)
        
        NSLayoutConstraint.activate([
            infoStackViewTopConstraint,
            infoStackViewBottomConstraint,
            infoStackViewLeadingConstraint,
            infoStackViewTrailingConstraint,
            
            avatarImageViewAspectRatioConstraint,
            
            self.setStatusButtonTopConstraint,
            setStatusButtonLeadingConstraint,
            setStatusButtonTrailingConstraint,
            setStatusButtonHeightConstraint,
            
            statusTextFieldTopConstraint,
            statusTextFieldLeadingConstraint,
            statusTextFieldTrailingConstraint,
            statusTextFieldHeightConstraint
        ].compactMap({$0}))
    }
    
    func hideKeyboard() {
        self.statusTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        hideKeyboard()
        return true
    }
    
    @objc private func didTapStatusButton() {
        if self.statusTextField.isHidden {
            self.setStatusButtonBottomConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            NSLayoutConstraint.deactivate([self.setStatusButtonTopConstraint].compactMap({$0}))
            NSLayoutConstraint.activate([self.setStatusButtonBottomConstraint].compactMap({$0}))
            self.statusTextField.isHidden = false
        } else {
            self.setStatusButtonTopConstraint = self.setStatusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 10)
            NSLayoutConstraint.deactivate([self.setStatusButtonBottomConstraint].compactMap({$0}))
            NSLayoutConstraint.activate([self.setStatusButtonTopConstraint].compactMap({$0}))
            self.statusTextField.isHidden = true
            self.statusLabel.text = self.statusTextField.text
            if self.statusLabel.text == "" {
                self.statusLabel.text = self.statusText
            }
        }
        
        self.delegate?.didTapStatusButton(textFieldIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
        
    }
    
    func changeTitle(title: String) {
        self.fullNameLabel.text = title
    }
    
}
