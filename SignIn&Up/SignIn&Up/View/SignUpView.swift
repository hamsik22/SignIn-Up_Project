//
//  SignUpView.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import UIKit

class SignUpView: UIView {
    
    weak var delegate: AuthManagable?
    private let manager: AuthManager = .shared
    
    private var headTitle: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        return label
    }()
    private var emailHeader: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    private var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    private var passwordHeader: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    private var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    private var confirmPasswordHeader: UILabel = {
        let label = UILabel()
        label.text = "Confirm Password"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    private var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    private var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        return button
    }()
    private var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupUI()
        addActions()
    }
    
    private func addSubViews() {
        let subViews = [headTitle,
                        emailHeader,emailTextField,
                        passwordHeader, passwordTextField,
                        confirmPasswordHeader, confirmPasswordTextField,
                        signUpButton]
        
        subViews.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            headTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 32),
            headTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            emailHeader.topAnchor.constraint(equalTo: headTitle.bottomAnchor, constant: 24),
            emailHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            emailHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            emailTextField.topAnchor.constraint(equalTo: emailHeader.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            passwordHeader.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            passwordHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            passwordHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordHeader.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            confirmPasswordHeader.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            confirmPasswordHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            confirmPasswordHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordHeader.bottomAnchor, constant: 8),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            signUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 32),
            signUpButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    private func addActions() {
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SignUpView {
    
    @objc func signUpButtonTapped() {
        if manager.validateEmail("") {
            delegate?.didSignUpSuccess()
        } else {
            delegate?.didSignUpFailure("회원가입 실패")
        }
    }
}
