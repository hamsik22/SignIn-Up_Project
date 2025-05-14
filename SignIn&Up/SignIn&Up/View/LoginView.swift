//
//  LoginView.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import UIKit

class LoginView: UIView {
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

extension LoginView {
    private func addSubViews() { }
    private func setupUI() { }
    private func addActions() { }
}
