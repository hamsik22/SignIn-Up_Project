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
    
    var validations: (Bool, Bool, Bool, Bool) = (false, false, false, false) {
        didSet { validationStatusChanged?(validations.0, validations.1, validations.2, validations.3)}
    }
    var validationStatusChanged: ((Bool, Bool, Bool, Bool) -> Void)?
    

    
    // MARK: 이메일 유효성 확인
    func validateEmail(_ email: String) -> (Bool, String) {
        let emailRegex = "^[a-z][a-z0-9]{5,19}@[a-zA-Z]+\\.[a-zA-Z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if emailPredicate.evaluate(with: email) {
            validations.0 = true
            return (true, "사용가능한 이메일입니다!")
        } else {
            // 조건별 에러 메시지
            if !email.contains("@") {
                validations.0 = false
                return (false, "이메일 형식이 올바르지 않습니다.")
            }
            
            let components = email.split(separator: "@")
            guard let localPart = components.first else {
                validations.0 = false
                return (false, "이메일 형식이 올바르지 않습니다.")
            }
            
            if localPart.count < 6 || localPart.count > 20 {
                validations.0 = false
                return (false, "이메일의 아이디는 최소 6자 이상, 최대 20자 이하여야 합니다.")
            }
            
            let localRegex = "^[a-z][a-z0-9]{5,19}$"
            let localPredicate = NSPredicate(format: "SELF MATCHES %@", localRegex)
            
            if !localPredicate.evaluate(with: String(localPart)) {
                validations.0 = false
                return (false, "이메일의 아이디 부분은 영문 소문자(a-z)로 시작해야 하며, 숫자로 시작할 수 없습니다.")
            }
            
            validations.0 = false
            return (false, "이메일 형식이 올바르지 않습니다.")
        }
    }
    
    // MARK: 비밀번호 유효성 검사
    func validatePassword(_ password: String) -> (Bool, String) {
        guard password.count >= 8 else {
            validations.1 = false
            return (false, "비밀번호는 최소 8자 이상이어야 합니다.")
        }
        
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$%^&*()_+=\\-`~${}|;:'\",.<>?/]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        if passwordPredicate.evaluate(with: password) {
            validations.1 = true
            return (true, "사용 가능한 비밀번호입니다!")
        } else {
            validations.1 = false
            return (false, "비밀번호는 영문 대소문자, 숫자, 특수문자를 포함해야 합니다.")
        }
    }
    
    // MARK: 비밀번호 확인 유효성 검사
    func checkConfirmPassword(_ password: String, _ confirmPassword: String) -> (Bool, String) {
        let isValid = password == confirmPassword
        validations.2 = isValid
        return (isValid, isValid ? "비밀번호가 일치합니다!" : "비밀번호가 일치하지 않습니다.")
    }
    
    // MARK: 닉네임 입력 확인
    func checkNickname(_ nickname: String) {
        if !nickname.isEmpty {
            validations.3 = true
        } else {
            validations.3 = false
        }
    }
}

// MARK: - CoreData Methods
extension AuthManager {
    
    // MARK: 회원가입
    func signUp(email: String, password: String, nickname: String) -> Bool {
        if isEmailDuplicated(email: email) {
            debugPrint("\(email): 이미 존재하는 이메일입니다.")
            return false
        }

        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
        newUser.setValue(UUID().uuidString, forKey: "id")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(password, forKey: "password")
        newUser.setValue(true, forKey: "isLoggedIn")
        newUser.setValue(nickname, forKey: "nickname")
        
        do {
            try context.save()
            debugPrint("\(email): 회원가입 성공")
            return true
        } catch {
            print("\(error.localizedDescription): 회원가입 실패")
            return false
        }
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
            return results.first?.value(forKey: "nickname") as! String
        } catch {
            print("이메일 중복 확인 중 오류 발생: \(error.localizedDescription)")
        }
        return ""
    }
}
