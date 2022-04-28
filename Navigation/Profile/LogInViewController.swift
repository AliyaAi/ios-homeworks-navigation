//
//  LogInViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 17.03.2022.
//
import UIKit
import Foundation

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let logoImage = UIImageView(image: UIImage(named: "logo"))
    private let textFieldscontentView = UIView()
    private let separator = UIView()
    private let labelAlert = UILabel()
    private let logInButton = UIButton()
    private let loginTextField = UITextField()
    private let passwordTextField = UITextField()
    
    private func setupConstraints() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        contentView.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100)
        ])
        
        NSLayoutConstraint.activate([
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120)
        ])
        
        contentView.addSubview(textFieldscontentView)
        textFieldscontentView.backgroundColor = .systemGray6
        textFieldscontentView.layer.borderColor = UIColor.lightGray.cgColor
        textFieldscontentView.layer.borderWidth = 0.5
        textFieldscontentView.layer.cornerRadius = 10
        textFieldscontentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldscontentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textFieldscontentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textFieldscontentView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            textFieldscontentView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        textFieldscontentView.addSubview(separator)
        separator.backgroundColor = UIColor.lightGray
        separator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            separator.leadingAnchor.constraint(equalTo: textFieldscontentView.leadingAnchor, constant: 0),
            separator.trailingAnchor.constraint(equalTo: textFieldscontentView.trailingAnchor, constant: 0),
            separator.centerYAnchor.constraint(equalTo: textFieldscontentView.centerYAnchor),
            separator.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        loginTextField.textColor = .black
        loginTextField.placeholder = "Email or phone"
        loginTextField.font = UIFont.systemFont(ofSize: 16)
        loginTextField.autocapitalizationType = .none
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.delegate = self
        textFieldscontentView.addSubview(loginTextField)
        
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.placeholder = "Password"
        passwordTextField.autocapitalizationType = .none
        passwordTextField.delegate = self
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.isSecureTextEntry = true
        textFieldscontentView.addSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: textFieldscontentView.leadingAnchor, constant: 8),
            loginTextField.trailingAnchor.constraint(equalTo: textFieldscontentView.trailingAnchor, constant: -8),
            loginTextField.centerYAnchor.constraint(equalTo: textFieldscontentView.centerYAnchor, constant: -25),
            
            passwordTextField.leadingAnchor.constraint(equalTo: textFieldscontentView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: textFieldscontentView.trailingAnchor, constant: -8),
            passwordTextField.centerYAnchor.constraint(equalTo: textFieldscontentView.centerYAnchor, constant: +25),
        ])
        
        contentView.addSubview(logInButton)
        logInButton.setBackgroundImage(UIImage.init(named: "blue_pixel"), for: .normal)
        logInButton.setTitle("Log in", for: .normal)
        logInButton.layer.cornerRadius = 10
        logInButton.layer.masksToBounds = true
        logInButton.setTitleColor(.white, for: .normal)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.topAnchor.constraint(equalTo: textFieldscontentView.bottomAnchor, constant: 36),
            logInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        contentView.addSubview(labelAlert)
        labelAlert.text = "The minimum of password characters is 6 long"
        labelAlert.textColor = .red
        labelAlert.isHidden = true
        labelAlert.adjustsFontSizeToFitWidth = true
        labelAlert.sizeToFit()
        labelAlert.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelAlert.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            labelAlert.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            labelAlert.bottomAnchor.constraint(equalTo: logInButton.topAnchor, constant: -5),
            labelAlert.centerXAnchor.constraint(equalTo: logInButton.centerXAnchor)
        ])
    }
    
    @objc func loginPressed() {
        if loginTextField.text?.count == 0 {
            textFieldscontentView.layer.borderColor = UIColor.red.cgColor
            separator.backgroundColor = .red
            loginTextField.becomeFirstResponder()
            return
        }
        if passwordTextField.text?.count == 0 {
            textFieldscontentView.layer.borderColor = UIColor.red.cgColor
            separator.backgroundColor = .red
            passwordTextField.becomeFirstResponder()
            return
        }
        if (passwordTextField.text?.count ?? 0) < 6 {
            labelAlert.isHidden = false
            return
        }
        if loginTextField.text != "Zendaya" || passwordTextField.text != "123456789" {
            let alert = UIAlertController.init(title: "Access denied", message: " You didn't write correct password and login!", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: .default))
            present(alert, animated: true)
            return
        }
        let profile = ProfileViewController()
        self.navigationController?.pushViewController(profile, animated: true)
    }
    @objc func kbdShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    @objc func kbdHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbdShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.kbdHide(notification:)), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        labelAlert.isHidden = true
        textFieldscontentView.layer.borderColor = UIColor.lightGray.cgColor
        separator.backgroundColor = .lightGray
        return true
    }
}
