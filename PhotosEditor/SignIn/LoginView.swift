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
        NavigationView {
            VStack {
                
                Spacer()
                
                VStack(spacing: 24) {
                    
                    TextField("Email", text: $viewModel.email)
                        .customTextFieldStyle()
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                    
                    SecureField("Password", text: $viewModel.password)
                        .customTextFieldStyle()
                    
                    Button("Восстановить пароль") {
                        viewModel.showForgotPasswordView.toggle()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Button("Войти") {
                            viewModel.login {
                                viewModel.isLoggIn.toggle()
                            }
                        }
                        .customButtonStyle()
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    }
                    
                    GoogleSignInButton {
                        GoogleSignInService.share.signInWithGoogle(presenting: getRootViewController()) { error in
                            print("Error\(String(describing: error))")
                        }
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    NavigationLink(destination: GalleryView(), isActive: $viewModel.isLoggIn) {
                        EmptyView()
                    }
                }
                .padding()
                .sheet(isPresented: $viewModel.showForgotPasswordView) {
                    ForgotPasswordView()
                }
                .sheet(isPresented: $viewModel.showRegistrationView) {
                    RegistrationView()
                }
                
                Spacer()
                
                Button("Зарегестрироваться") {
                    viewModel.showRegistrationView.toggle()
                }
                .foregroundColor(.blue)
                .padding()
            }
        }
    }
}

#Preview {
    LoginView()
}
