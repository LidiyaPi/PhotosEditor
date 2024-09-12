//
//  ContentView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 11.09.2024.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $viewModel.email)
                .border(.primary)
                .keyboardType(.emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            SecureField("Password", text: $viewModel.password)
                .border(.primary)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Button("Login") {
                viewModel.login()
                print("Переходим на другой экран")
            }
            
            Button("Login with Google") {
            }
            
            Button("Forgot password?") {
                viewModel.showPasswordRecovery()
            }
            .padding()
        }

        .alert(item: $viewModel.errorMessage) { error in
               Alert(title: Text(error.title), message: Text(error.message), dismissButton: .default(Text("OK")))
           }
    }
}



#Preview {
    LoginView()
}
