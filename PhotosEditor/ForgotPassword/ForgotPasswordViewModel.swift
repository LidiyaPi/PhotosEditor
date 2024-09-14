//
//  ForgotPasswordViewModel.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 14.09.2024.
//

import Foundation
import FirebaseAuth



@MainActor
class ForgotPasswordViewModel:ObservableObject {
    
    @Published var email: String = ""
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    @Published var successMessage: String?
//    @Published private (set) var forgotPasswordState = ForgotPasswordState.initial

    
    func resetPassword(email: String) {
        guard isValidEmail(email) else {
            successMessage = "Пожалуйста, введите корректный email."
            showAlert = true
            return
        }
        
        Auth.auth().fetchSignInMethods(forEmail: email) { (methods, error) in
            if let error = error {
                self.errorMessage = error.localizedDescription
                self.showAlert = true
                return
            }
            
            if methods == nil || methods!.isEmpty {
                self.successMessage = "Пользователь с таким email не найден."
                self.showAlert = true
                return
            }
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
                print("ОШИБКА\(error.localizedDescription)")
            } else {
                self.successMessage = "Ссылка на восстановление отправлена на ваш email."
            }
            self.showAlert = true
            
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
}
