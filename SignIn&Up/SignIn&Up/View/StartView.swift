//
//  StartView.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import UIKit

class StartView: UIView {
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubViews() {
        [welcomeText, startButton]
            .forEach { self.addSubview($0) }
    }
    
    private func setupUI() {
        
        NSLayoutConstraint.activate([
            welcomeText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            welcomeText.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            welcomeText.widthAnchor.constraint(equalToConstant: 200),
            welcomeText.heightAnchor.constraint(equalToConstant: 50),
            
            startButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 20),
            startButton.widthAnchor.constraint(equalToConstant: 100),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
