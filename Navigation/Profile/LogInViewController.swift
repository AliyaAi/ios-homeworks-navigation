//
//  LogInViewController.swift
//  Navigation
//
//  Created by Александр Якубов on 17.03.2022.
//
import UIKit

class LogInViewController: UIViewController {

    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        return contentView
    }()

    private var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()

    private var emailPasswordStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layer.borderWidth = 0.5
        stack.layer.cornerRadius = 10
        stack.clipsToBounds = true
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private var emailTextField: UITextField = {
        let textField  = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.placeholder = "Email or phone"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.tintColor = UIColor(named: "accentColor-1")
        textField.clearButtonMode = .always
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.returnKeyType = .done
        textField.keyboardAppearance = .alert
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.backgroundColor = .systemGray6
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.placeholder = "Password"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.tintColor = UIColor(named: "accentColor-1")
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        textField.keyboardAppearance = .alert
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    private var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.titleLabel?.textColor = .white
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapLogInButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.textColor = .systemRed
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Пароль должен содержать от 8 до 16 символов"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func alphaForButton() {
        switch logInButton.state {
        case .normal:
            self.logInButton.alpha = 1.0
        case .selected, .disabled, .highlighted:
            self.logInButton.alpha = 0.8
        default:
            self.logInButton.alpha = 0.8
        }
    }

    private var stackToButton: NSLayoutConstraint?
    private var alertToButton: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.view.addSubview(scrollView)
        self.scrollView.contentSize = self.view.bounds.size
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(logoImage)
        self.contentView.addSubview(emailPasswordStack)
        self.emailPasswordStack.addArrangedSubview(self.emailTextField)
        self.emailPasswordStack.addArrangedSubview(self.passwordTextField)
        self.contentView.addSubview(logInButton)
        self.contentView.addSubview(alertLabel)
        self.setupView()
        self.alphaForButton()
    }

    private func setupView() {
        self.view.backgroundColor = .white

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

            self.contentView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            self.contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor),

            NSLayoutConstraint(item: logoImage, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1, constant: 1),
            self.logoImage.widthAnchor.constraint(equalToConstant: 100),
            self.logoImage.heightAnchor.constraint(equalTo: self.logoImage.widthAnchor, multiplier: 1),

            self.emailPasswordStack.heightAnchor.constraint(equalToConstant: 100),
            self.emailPasswordStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.emailPasswordStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),


            self.logInButton.heightAnchor.constraint(equalToConstant: 50),
            self.logInButton.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.logInButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.logInButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),

            self.alertLabel.topAnchor.constraint(equalTo: self.emailPasswordStack.bottomAnchor, constant: 16),
            self.alertLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 16),
            self.alertLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])

        self.stackToButton = self.emailPasswordStack.bottomAnchor.constraint(equalTo: self.logInButton.topAnchor, constant: -16)
        NSLayoutConstraint.activate([self.stackToButton].compactMap( { $0 }))

        let heightView = UIScreen.main.bounds.height
        if heightView < 780 {
            NSLayoutConstraint.activate([
                self.emailPasswordStack.centerYAnchor.constraint(equalTo: self.contentView.topAnchor, constant: heightView/2),
                self.logoImage.centerYAnchor.constraint(equalTo: self.contentView.topAnchor, constant: heightView/4)
            ])
        } else {
            NSLayoutConstraint.activate([
            self.logoImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 120),
            self.logoImage.bottomAnchor.constraint(equalTo: self.emailPasswordStack.topAnchor, constant: -120)
            ])
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.alphaForButton()
    }

    @objc func didTapLogInButton() {
        self.view.endEditing(true)

        var count = 0
        var flag = true

        if let email = emailTextField.text {
            if email.isEmpty {
                self.shakeTextField(textField: emailTextField)
                count += 1
            } else {
                if email != correctLogin {
                    flag = false
                }
            }
        }

        if let password = passwordTextField.text {
            if password.isEmpty {
                self.shakeTextField(textField: passwordTextField)
                count += 1
            } else {
                let passwordLength = password.count
                if (passwordLength < 8) || (passwordLength > 16) {
                    self.alertLabel.isHidden = false

                    NSLayoutConstraint.deactivate([self.stackToButton].compactMap( { $0 }))

                    self.alertToButton = self.alertLabel.bottomAnchor.constraint(equalTo: self.logInButton.topAnchor, constant: -16)
                    NSLayoutConstraint.activate([self.alertToButton].compactMap( { $0 }))

                    count += 1
                } else {
                    self.alertLabel.isHidden = true
                    NSLayoutConstraint.deactivate([self.alertToButton].compactMap( { $0 }))
                    NSLayoutConstraint.activate([self.stackToButton].compactMap( { $0 }))
                }
                if password != correctPassword {
                    flag = false
                }
            }
        }

        if flag && (count == 0) {
            let profileVC = ProfileViewController()
            profileVC.closure = {
            }
            self.navigationController?.pushViewController(profileVC, animated: true)
        } else if (count == 0) && flag != true {
            let alert = UIAlertController(title: "Внимание!", message: "Введенные логин и пароль не совпадают", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Попробовать ещё", style: .cancel, handler: { (_) in
                self.passwordTextField.text = ""
                self.emailTextField.text = ""
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(kbdShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.addObserver(self, selector: #selector(kbdHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let nc = NotificationCenter.default
        nc.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        nc.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func kbdShow(notification: NSNotification) {
        if let kbdSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = kbdSize.height
            let offset = self.contentView.frame.height + kbdSize.height - self.view.frame.height
            if offset > 0 {
                self.scrollView.contentOffset = CGPoint(x: 0, y: offset)
            }
        }
    }

    @objc private func kbdHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    private func shakeTextField(textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 2, y: textField.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 2, y: textField.center.y))
        textField.layer.add(animation, forKey: "position")
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder ?? "",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }

}
