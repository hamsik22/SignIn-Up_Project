//
//  SignUpView.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import UIKit

class SignUpView: UIView, UITextFieldDelegate {
    
    weak var delegate: AuthManagable?
    private let manager: AuthManager = .shared
    
    private var validations: (Bool, Bool, Bool) = (false, false, false)
    
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
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
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
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textContentType = .oneTimeCode
        textField.isSecureTextEntry = true
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
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.textContentType = .oneTimeCode
        textField.isSecureTextEntry = true
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
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Layout
extension SignUpView {
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
        /// SignUpButton Action
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        
        /// KeyBoard Dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(tapGesture)
        
        /// SignUpButton Appearance
        signUpButton.isEnabled = manager.isValidationSucceeded
        manager.validationStatusChanged = { [weak self] isValid in
            self?.signUpButton.isEnabled = isValid
        }
    }
}

// MARK: Function
extension SignUpView {
    
    /// 키보드 비활성화
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    /// SignUp 버튼 터치 시 동작
    @objc func signUpButtonTapped() {
        if manager.isValidationSucceeded {
            guard let emailText = emailTextField.text,
                  let passwordText = passwordTextField.text else { return }
            if manager.signUp(email: emailText, password: passwordText) {
                delegate?.didSignUpSuccess(email: emailText, password: passwordText)
            } else {
                delegate?.didSignUpFailure("회원가입 실패")
            }
        }
    }
    
    /// 텍스트필드에 글자를 입력할 때마다 값을 검증하는 로직
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text as NSString? else { return true }
        let updatedText = currentText.replacingCharacters(in: range, with: string)
        var validations: (Bool, Bool, Bool) = (false, false, false)
        
        if textField == emailTextField {
            let validation = manager.validateEmail(updatedText)
            updateTextFieldAppearance(textField, isValid: validation.0, errorMessage: validation.1)
            validations.0 = validation.0
        } else if textField == passwordTextField {
            let validation = manager.validatePassword(updatedText)
            updateTextFieldAppearance(textField, isValid: validation.0, errorMessage: validation.1)
            validations.1 = validation.0
        } else if textField == confirmPasswordTextField {
            if let passwordText = passwordTextField.text {
                let validation = manager.checkConfirmPassword(passwordText, updatedText)
                updateTextFieldAppearance(textField, isValid: validation.0, errorMessage: validation.1)
                validations.2 = validation.0
                if validations.0 && validations.1 && validations.2 { manager.isValidationSucceeded = true }
            }
        }
        
        return true
    }
    
    /// 값이 업데이트됨에 따라 UI를 수정하는 함수
    private func updateTextFieldAppearance(_ textField: UITextField, isValid: Bool, errorMessage: String) {
        if isValid {
            textField.layer.borderColor = UIColor.green.cgColor
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 5
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 5
            print(errorMessage)
        }
    }
}
