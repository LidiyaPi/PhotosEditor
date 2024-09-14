//
//  ContentView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 11.09.2024.
//

import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
    
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var showRegistrationView = false
    @State private var isLoggedIn = false
    @State private var showForgotPasswordView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                
                TextField("Email", text: $loginViewModel.email)
                    .customTextFieldStyle()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $loginViewModel.password)
                    .customTextFieldStyle()
                
                Button("Forgot password") {
                    showForgotPasswordView.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                if loginViewModel.isLoading {
                    ProgressView()
                } else {
                    Button("Login") {
                        loginViewModel.login {
                            isLoggedIn = true
                        }
                    }
                    .customButtonStyle()
                }
                
                Text("or")
                
                GoogleSignInButton {
                    GoogleSignInService.share.signInWithGoogle(presenting: getRootViewController()) { error in
                        print("Error\(String(describing: error))")
                    }
                }
                
                Button("Don't have an account?") {
                    showRegistrationView.toggle()
                }
                .foregroundColor(.blue)
                .padding()
                
                if let errorMessage = loginViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                
                NavigationLink(destination: GalleryView(), isActive: $loginViewModel.isLoggedIn) {
                    EmptyView()
                }
                            }
            .padding()
            .sheet(isPresented: $showForgotPasswordView) {
                     ForgotPasswordView()
                 }
            .sheet(isPresented: $showRegistrationView) {
                RegistrationView()
            }
            .background(
                
            )
        }
    }
}



#Preview {
    LoginView()
}
