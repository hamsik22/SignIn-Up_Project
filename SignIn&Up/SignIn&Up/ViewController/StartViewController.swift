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
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        startView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startView.widthAnchor.constraint(equalToConstant: 300),
            startView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

// MARK: AuthManagable
extension StartViewController: AuthManagable {
    func didSignUpSuccess(email: String, password: String) {
        // TODO: 로그인 화면으로 이동
        manager.signUp(email: email, password: password)
        let vc = LoginViewController()
        vc.delegate = self
        dismiss(animated: true)
        present(LoginViewController(), animated: true)
    }
    
    func didSignUpFailure(_ error: String) {
        // TODO: 회원가입 실패 문구 출력 후 입력값 초기화
    }
    
    func didLoginSuccess() {
        // TODO: 로그인 화면으로 이동
        present(LoginViewController(), animated: true)
    }
    
    func didLoginFailure(_ error: String) {
        // TODO: 로그인 실패 문구 출력 후 회원가입 화면으로 이동
        print("\(error) : 회원가입 화면으로 이동합니다")
        let vc = SignUpViewController()
        vc.delegate = self
        present(vc, animated: true)
    }
    
    func didLogout() {
        // TODO: 시작화면으로 이동
        dismiss(animated: true)
    }
    
    func didDeleteAccountSuccess() {
        // TODO: 회원정보 삭제 후 시작화면으로 이동
        dismiss(animated: true)
    }
    
    func didDeleteAccountFailure(_ error: String) {
        // TODO: 회원정보 삭제 실패 문구 출력
    }
    
}
