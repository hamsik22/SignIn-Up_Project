//
//  SignUpManagable.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import Foundation

protocol AuthManagable: AnyObject {
    
    // MARK: 회원가입 관련
    func didSignUpSuccess()
    func didSignUpFailure(_ error: String)
    
    // MARK: 로그인 관련
    func didLoginSuccess()
    func didLoginFailure(_ error: String)
    
    // MARK: 로그아웃 관련
    func didLogout()
    
    // MARK: 계정 삭제
    func didDeleteAccountSuccess()
    func didDeleteAccountFailure(_ error: String)
}
