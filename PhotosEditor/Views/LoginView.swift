//
//  ContentView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 11.09.2024.
//

import SwiftUI
import GoogleSignInSwift

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
            
            Button(action: {
                viewModel.showPasswordRecovery()
            }) {
                HStack {
                    Spacer()
                    Text("Forgot password?")
                }
            }.padding(.horizontal)
            
            Button("Login") {
                viewModel.login()
                print("Переходим на другой экран")
            }
            .buttonStyle(.bordered)
            
            Text("or")
            
            GoogleSignInButton {
                AuthService.share.signInWithGoogle(presenting: getRootViewController()) { error in
                    print("Error\(String(describing: error))")
                }
            }
            .scenePadding(.horizontal)
            
        }
        
        .alert(item: $viewModel.errorMessage) { error in
            Alert(title: Text(error.title), message: Text(error.message), dismissButton: .default(Text("OK")))
        }
    }
    
}


#Preview {
    LoginView()
}
