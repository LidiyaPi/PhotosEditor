//
//  LoginViewModel.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//

import Combine
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var isLoggedIn: Bool = false
    
    func login(completion: @escaping () -> Void) {
           isLoading = true
           AuthService.shared.login(email: email, password: password) { result in
               DispatchQueue.main.async {
                   self.isLoading = false
                   switch result {
                   case .success(let user):
                       print("User signed in: \(user.email)")
                       self.errorMessage = nil
                       completion()
                       self.isLoggedIn = true 
                   case .failure(let error):
                       self.errorMessage = error.localizedDescription
                   }
               }
           }
       }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailReg = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:  "SELF MATCHES %@", emailReg)
        return emailTest.evaluate(with: email)
    }
    
    
    func showPasswordRecovery() {
        
    }
    
}
