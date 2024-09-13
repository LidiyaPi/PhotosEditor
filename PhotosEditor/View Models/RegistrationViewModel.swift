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
    @Published var successMessage: String?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    func register() {
        AuthService.shared.register(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(_):
                    self.successMessage = "Регистрация прошла успешно"
                    self.errorMessage = nil
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func sendEmailVerification(completion: @escaping (Error?) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification { error in
            completion(error)
            print(error?.localizedDescription as Any)
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


