//
//  AuthManager.swift
//  SignIn&Up
//
//  Created by 황석현 on 5/14/25.
//

import CoreData
import UIKit

class AuthManager {
    
    static let shared = AuthManager()
    private init() { }
    
    private var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    var isUserLoggedIn: Bool { return false }
    
    var isValidationSucceeded: Bool = false {
        didSet {
            validationStatusChanged?(isValidationSucceeded)
        }
    }
    var validationStatusChanged: ((Bool) -> Void)?
    
    // MARK: 회원가입
    func signUp(email: String, password: String) {
        
    }
    
    // MARK: 이메일 유효성 확인
    func validateEmail(_ email: String) -> (Bool, String) {
        let emailRegex = "^[a-zA-Z0-9]+@[a-zA-Z]+\\.[a-zA-Z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if emailPredicate.evaluate(with: email) {
            return (true, "")
        } else {
            return (false, "이메일 형식이 올바르지 않습니다.")
        }
    }
    
    // MARK: 이메일 중복 확인
    func isEmailDuplicated() -> Bool { return false }
    
    // MARK: 비밀번호 유효성 검사
    func validatePassword(_ password: String) -> (Bool, String) {
        guard password.count >= 8 else {
            return (false, "비밀번호는 최소 8자 이상이어야 합니다.")
        }
        
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+=\\-`~${}|;:'\",.<>?/]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        if passwordPredicate.evaluate(with: password) {
            return (true, "사용 가능한 비밀번호입니다!")
        } else {
            return (false, "비밀번호는 영문 대소문자, 숫자, 특수문자를 포함해야 합니다.")
        }
    }
    
    func checkConfirmPassword(_ password: String, _ confirmPassword: String) -> (Bool, String) {
        let isValid = password == confirmPassword
        isValidationSucceeded = isValid
        return (isValid, isValid ? "비밀번호가 일치합니다!" : "비밀번호가 일치하지 않습니다.")
    }
    
    // MARK: 로그인
    func login() { }
    
    // MARK: 로그아웃
    func logOut() { }
    
    // MARK: 계정 삭제
    func deleteAccount() { }
    
    // MARK: 로그인 상태 확인
    func isLoggedIn() { }
    
    // MARK: 현재 로그인된 사용자 정보 가져오기
    func getCurrentUser() { }
}
