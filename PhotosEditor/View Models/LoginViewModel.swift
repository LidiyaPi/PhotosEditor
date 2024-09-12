//
//  LoginViewModel.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//

import Combine
import FirebaseAuth

struct AlertItem: Identifiable {
    let id = UUID()
    let title: String
    let message: String
}

class LoginViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var errorMessage: AlertItem?
    
    func login() {
        guard isValidEmail(email) else {
            errorMessage = AlertItem(title: "Error", message: "Invalid email format")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { result,
            error in
            if let error = error {
                self.errorMessage = AlertItem(title: "Error", message: error.localizedDescription)
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
