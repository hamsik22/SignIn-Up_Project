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
    
    // MARK: 회원가입
    func signUp(email: String) { }
    
    // MARK: 이메일 유효성 확인
    func validateEmail(_ email: String) -> Bool { return true }
    
    // MARK: 이메일 중복 확인
    func isEmailDuplicated() -> Bool { return false }
    
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
