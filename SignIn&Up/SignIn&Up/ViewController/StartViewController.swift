//
//  ViewController.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import UIKit

class StartViewController: UIViewController {
    
    private var startView = StartView()
    
    private var manager: AuthManager = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(startView)
        startView.delegate = self
        setupUI()
    }
    
    
}

// MARK: - Layout
extension StartViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        startView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startView.widthAnchor.constraint(equalTo: view.widthAnchor),
            startView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}

// MARK: AuthManagable
extension StartViewController: AuthManagable {
    
    func didSignUpSuccess() {
        let vc = LoginViewController()
        vc.delegate = self
        dismiss(animated: true)
        present(vc, animated: true)
    }
    
    func didSignUpFailure(_ error: String) {
        print(error)
    }
    
    func didLoginSuccess() {
        let vc = LoginViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func didLoginFailure(_ error: String) {
        print("\(error) : 회원가입 화면으로 이동합니다")
        let vc = SignUpViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func didLogout() {
        dismiss(animated: true)
    }
    
    func didDeleteAccountSuccess() {
        dismiss(animated: true)
    }
    
    func didDeleteAccountFailure(_ error: String) {
        print(error)
    }
    
}
