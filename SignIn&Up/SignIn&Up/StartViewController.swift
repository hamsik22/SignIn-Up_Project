//
//  ViewController.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import UIKit

class StartViewController: UIViewController, AuthManagable {
    
    
    private var manager = AuthManager()
    
    private var welcomeText: UILabel = {
        let label = UILabel()
        label.text = "Welcome to\nSignIn&Up"
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .purple
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var startButton: UIButton = {
        let button = UIButton()
        button.setTitle( "Start", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setupUI()
        
        manager.delegate = self
    }
    
    private func addSubViews() {
        [welcomeText, startButton]
            .forEach { view.addSubview($0) }
    }
    
    private func setupUI() {
        
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            welcomeText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeText.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeText.widthAnchor.constraint(equalToConstant: 200),
            welcomeText.heightAnchor.constraint(equalToConstant: 50),
            
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 20),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

