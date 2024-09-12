//
//  ContentView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 11.09.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Login") {
                if !email.isEmpty,
                   email == "1",
                   !password.isEmpty,
                   email == "1" {
                    print("Переходим на другой экран")
                } else {
                    errorMessage = "DASDASDA"
                }
            }
            Button("Login with Google") {
            }
            
            Button("Forgot password?") {
            }
//            .alert(item: $viewModel.errorMessage) { error in
//                Alert(title: Text("Error"), message: Text(error), dismissButton: .default(Text("OK")))
//            }
        }
    }
}

#Preview {
    LoginView()
}
