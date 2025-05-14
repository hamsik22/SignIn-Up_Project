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
    
    var isValidationSucceeded: Bool = false {
        didSet { validationStatusChanged?(isValidationSucceeded)}
    }
    var validationStatusChanged: ((Bool) -> Void)?

    
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
    
    // MARK: 비밀번호 확인 유효성 검사
    func checkConfirmPassword(_ password: String, _ confirmPassword: String) -> (Bool, String) {
        let isValid = password == confirmPassword
        isValidationSucceeded = isValid
        return (isValid, isValid ? "비밀번호가 일치합니다!" : "비밀번호가 일치하지 않습니다.")
    }

}

// MARK: - CoreData Methods
extension AuthManager {
    
    // MARK: 회원가입
    func signUp(email: String, password: String) -> Bool {
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newUser.setValue(UUID().uuidString, forKey: "id")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(password, forKey: "password")
        newUser.setValue(true, forKey: "isLoggedIn")
        
        do {
            try context.save()
            debugPrint("\(email): 회원가입 성공")
            return true
        } catch {
            print("\(error.localizedDescription): 회원가입 실패")
        }
        return false
    }
    
    // MARK: 이메일 중복 확인
    func isEmailDuplicated(email: String) -> Bool {
        let request = NSFetchRequest<NSManagedObject>(entityName: "User")
        request.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let results = try context.fetch(request)
            return !results.isEmpty
        } catch {
            print("이메일 중복 확인 중 오류 발생: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: 로그인 상태 확인
    func isLoggedIn() -> Bool {
        let request = NSFetchRequest<NSManagedObject>(entityName: "User")
        request.predicate = NSPredicate(format: "isLoggedIn == true")
        
        do {
            let result = try context.fetch(request)
            return !result.isEmpty
        } catch {
            print("로그인 상태 확인 중 오류 발생: \(error.localizedDescription)")
            return false
        }
    }
    
    // MARK: 계정 삭제
    func deleteAccount() -> Bool {
        let request = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            let result = try context.fetch(request)
            if let user = result.first {
                context.delete(user)
                try context.save()
                print("회원탈퇴 완료")
                return true
            }
        } catch {
            print("\(error.localizedDescription): 회원탈퇴 실패")
        }
        return false
    }
    
    // MARK: 현재 로그인된 사용자 정보 가져오기
    func getCurrentUser() -> String {
        let request = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        do {
            let results = try context.fetch(request)
            return results.first?.value(forKey: "email") as! String
        } catch {
            print("이메일 중복 확인 중 오류 발생: \(error.localizedDescription)")
        }
        return ""
    }
}
