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
    
    private var headTitle: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        return label
    }()
    private var emailHeader: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    private var emailSubHeader: UILabel = {
        let label = UILabel()
        label.text = "이메일을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
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
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    private var passwordSubHeader: UILabel = {
        let label = UILabel()
        label.text = "비밀번호는 최소 8자 이상이어야 합니다."
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
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
        label.text = "비밀번호 확인"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    private var confirmPasswordSubHeader: UILabel = {
        let label = UILabel()
        label.text = "비밀번호를 한번 더 입력해주세요."
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
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
    private var nicknameHeader: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    private var nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        return textField
    }()
    private var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return button
    }()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
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

// MARK: - SetUp
extension SignUpView {
    private func addSubViews() {
        let subViews = [headTitle,
                        emailHeader,emailTextField,emailSubHeader,
                        passwordHeader,passwordTextField,passwordSubHeader,
                        confirmPasswordHeader,confirmPasswordTextField,confirmPasswordSubHeader,
                        nicknameHeader, nicknameTextField,
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
            
            emailSubHeader.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            emailSubHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            emailSubHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            passwordHeader.topAnchor.constraint(equalTo: emailSubHeader.bottomAnchor, constant: 24),
            passwordHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            passwordHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordHeader.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            passwordSubHeader.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            passwordSubHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            passwordSubHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            confirmPasswordHeader.topAnchor.constraint(equalTo: passwordSubHeader.bottomAnchor, constant: 24),
            confirmPasswordHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            confirmPasswordHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordHeader.bottomAnchor, constant: 8),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            confirmPasswordSubHeader.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 8),
            confirmPasswordSubHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            confirmPasswordSubHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            nicknameHeader.topAnchor.constraint(equalTo: confirmPasswordSubHeader.bottomAnchor, constant: 24),
            nicknameHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            nicknameHeader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            nicknameTextField.topAnchor.constraint(equalTo: nicknameHeader.bottomAnchor, constant: 8),
            nicknameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            nicknameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            
            signUpButton.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 50),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
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

// MARK: - Method
extension SignUpView {
    
    /// 키보드 비활성화
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
    
    /// SignUp 버튼 터치 시 동작
    @objc func signUpButtonTapped() {
        if manager.isValidationSucceeded {
            guard let emailText = emailTextField.text,
                  let passwordText = passwordTextField.text,
                  let nicknameText = nicknameTextField.text else { return }
            if manager.signUp(email: emailText, password: passwordText, nickname: nicknameText) {
                delegate?.didSignUpSuccess()
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
            updateTextFieldAppearance(textField, isValid: validation.0)
            updateSubHeaderAppearance(emailSubHeader, isValid: validation.0, errorMessage: validation.1)
            validations.0 = validation.0
        } else if textField == passwordTextField {
            let validation = manager.validatePassword(updatedText)
            updateTextFieldAppearance(textField, isValid: validation.0)
            updateSubHeaderAppearance(passwordSubHeader, isValid: validation.0, errorMessage: validation.1)
            validations.1 = validation.0
        } else if textField == confirmPasswordTextField {
            if let passwordText = passwordTextField.text {
                let validation = manager.checkConfirmPassword(passwordText, updatedText)
                updateTextFieldAppearance(textField, isValid: validation.0)
                updateSubHeaderAppearance(confirmPasswordSubHeader, isValid: validation.0, errorMessage: validation.1)
                validations.2 = validation.0
                if validations.0 && validations.1 && validations.2 { manager.isValidationSucceeded = true }
            }
        }
        
        return true
    }
    
    /// 값이 업데이트 됨에 따라 TextField의 테두리를 수정하는 함수
    private func updateTextFieldAppearance(_ textField: UITextField, isValid: Bool) {
        if isValid {
            textField.layer.borderColor = UIColor.green.cgColor
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 5
        } else {
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1.0
            textField.layer.cornerRadius = 5
        }
    }
    
    /// 값이 업데이트 됨에 따라 안내문구를 수정하는 함수
    private func updateSubHeaderAppearance(_ label: UILabel, isValid: Bool, errorMessage: String) {
        if isValid {
            label.textColor = .systemGray
            label.text = errorMessage
        } else {
            label.textColor = .red
            label.text = errorMessage
        }
    }
}
