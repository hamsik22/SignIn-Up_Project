//
//  SignUpViewController.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private var signUpView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signUpView)
        view.backgroundColor = .systemBackground
        setConstraints()
    }
    
    private func setConstraints() {
        signUpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpView.topAnchor.constraint(equalTo: view.topAnchor),
            signUpView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signUpView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            signUpView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
