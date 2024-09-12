//
//  ForgotPasswordView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 11.09.2024.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var successMessage: String?
    
    var body: some View {
        VStack {
            Text("Восстановление пароля")
                .font(.title2).bold()
                .padding()
            
            TextField("Email", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Отправить ссылку на восстановление") {
                resetPassword(email: email)
       
            }
            .padding()
        }
//        .alert(item: $successMessage) { message in
//                 Alert(title: Text("Success"), message: Text(message), dismissButton: .default(Text("OK")))
//             }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                successMessage = error.localizedDescription
            } else {
                self.successMessage = "Ссылка на восстановление отправлена на ваш email."
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}
