//
//  RegistrationViewModel.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//

import Combine
import FirebaseAuth

@MainActor
final class RegistrationViewModel: ObservableObject {
    
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var successMessage: String?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    @Published var showAlert = false
    
    func register() {
        Task {
        AuthService.shared.register(email: email, password: password) { result in
                self.isLoading = false
                self.showAlert = true
                switch result {
                case .success:
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
    
    private func sendEmailVerification() {
        Auth.auth().currentUser?.sendEmailVerification { error in
            if let error = error {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}


