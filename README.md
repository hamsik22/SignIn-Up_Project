# SignIn-Up_Project
본 프로젝트는 바로인턴 과제물로써     
`회원가입` & `로그아웃` & `회원탈퇴` 기능이 들어있는 예제 프로젝트입니다.

사용한 기술은 다음과 같습니다.

- `UIKit`
- `CoreData`

### 시연 영상
<div>
<img width="200" src="https://github.com/user-attachments/assets/871c5626-f125-4ede-9fa9-60e955916bce">
</div>

## 주요 기능
### 회원가입
- 이메일은 아래의 조건을 충족해야합니다.
  - `아이디는 최소 6자 이상, 최대 20자 이하`
  - `"@"를 포함`
  - `아이디 부분은 영문 소문자(a-z)로 시작해야 하며, 숫자로 시작할 수 없음.`
- 비밀번호는 아래의 조건을 충족해야합니다.
  - `최소 8자 이상`
  - `영문 대소문자, 숫자, 특수문자를 포함`

### 로그인 화면
회원가입 성공 or 로그인 성공 시, 로그인 화면으로 이동하며     
회원가입 시 입력한 닉네임과 함께 환영문구를 확인할 수 있습니다.

로그인 화면에는 아래 2개의 기능이 구현되어 있습니다.

- 로그아웃 : 시작화면으로 돌아가며, `Start`를 누르면 로그인 화면으로 이동한다.
- 회원탈퇴 : 회원정보를 삭제하고 시작화면으로 돌아가며, `Start`를 통해 회원가입을 해야한다.

## 구현 목표
- `Delegate` 패턴을 활용하여 코드의 유지보수성과 가독성을 높였습니다.
-	`MARK` 주석을 적극적으로 사용하여 코드의 구조를 명확히 구분하였습니다.
-	`extension`을 통해 각 기능별로 코드를 분리하여 가독성과 재사용성을 향상시켰습니다.
-	`UITextFieldDelegate`를 통해 입력값에 따른 유연한 안내 UI를 제공하도록 구현하였습니다.
-	`NotificationCenter`를 활용해 키보드에 의해 UI가 가려지는 문제를 해결하여 사용자 경험(UX)을 개선하였습니다.

#스크린샷

## 화면
| StartView  | SignUpView  | LoginView  |
|---|---|---|
| <img width="200" src="https://github.com/user-attachments/assets/6b65a256-6e21-4c9b-8c6b-b6a719e5c741">  |  <img width="200" src="https://github.com/user-attachments/assets/7871385e-3ae1-48ac-90f9-afaf6a7e8220">  |  <img width="200" src="https://github.com/user-attachments/assets/6b67e53e-9765-42c0-b54a-92fa05128bed">  |

### 입력값 검증
| 이메일  | 비밀번호  | 비밀번호 확인  |
|---|---|---|
| <img width="200" src="https://github.com/user-attachments/assets/a5238765-f7f3-41f4-ac32-e37fb002ef4e"> | <img width="200" src="https://github.com/user-attachments/assets/0df61d94-59b1-44bd-a7b5-06cd0d33f368"> | <img width="200" src="https://github.com/user-attachments/assets/a0a02e15-babb-420f-a277-7e9558d85ca9"> |
