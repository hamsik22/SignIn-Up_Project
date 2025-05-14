//
//  LoginView.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import UIKit

class LoginView: UIView {
    
    weak var delegate: AuthManagable?
    
    private let manager: AuthManager = .shared
    
    private var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "@@@ 님! \n 환영합니다!"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        return label
    }()
    
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupUI()
        addActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - SetUp
extension LoginView {
    private func addSubViews() {
        [welcomeLabel, logOutButton, signOutButton]
            .forEach {
                $0.translatesAutoresizingMaskIntoConstraints = false
                stackView.addArrangedSubview($0)
            }

        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
    }
    private func setupUI() {
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .fill
        
        welcomeLabel.textAlignment = .center
        welcomeLabel.numberOfLines = 2
        welcomeLabel.text = "\(manager.getCurrentUser())님!\n 환영합니다!"
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
            
            welcomeLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logOutButton.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            logOutButton.heightAnchor.constraint(equalToConstant: 50),
            
            signOutButton.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            signOutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func addActions() {
        logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        signOutButton.addTarget(self, action: #selector(signOutTapped), for: .touchUpInside)
    }
}

// MARK: - Method
extension LoginView {
    
    @objc func logOutTapped() {
        print("LogOut Tapped")
        delegate?.didLogout()
    }
    
    @objc func signOutTapped() {
        print("SignOut Tapped")
        if manager.deleteAccount() {
            print("didDeleteAccountSuccess")
            delegate?.didDeleteAccountSuccess()
        } else {
            print("didDeleteAccountFailure")
            delegate?.didDeleteAccountFailure("회원탈퇴 실패")
        }
    }
}
