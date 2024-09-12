//
//  RegistrationViewModel.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//

import Combine
import FirebaseAuth

class RegistrationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: String?
    
    func register() {
        guard isValidEmail(email) else {
            errorMessage = "Invalid email format"
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { Result, error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            } else {
                self.sendEmailVerification()
            }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    private func sendEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
}


