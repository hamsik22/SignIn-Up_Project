//
//  LoginViewController.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var logInView = LoginView()
    
    weak var delegate: AuthManagable? {
        didSet {
            logInView.delegate = delegate
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print("LoginViewController - Delegate: \(String(describing: delegate))")
    }
}

extension LoginViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        logInView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logInView)
        
        NSLayoutConstraint.activate([
            logInView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logInView.widthAnchor.constraint(equalTo: view.widthAnchor),
            logInView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
}
