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
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                
                TextField("Email", text: $loginViewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                
                SecureField("Password", text: $loginViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if loginViewModel.isLoading {
                    ProgressView()
                } else {
                    Button("Login") {
                        loginViewModel.login()
                        print("HOORAY")
                    }
                    .buttonStyle(NewButtonStyle())
                    .padding()
                }
                
                Text("or")
                
                GoogleSignInButton {
                    GoogleSignInService.share.signInWithGoogle(presenting: getRootViewController()) { error in
                        print("Error\(String(describing: error))")
                    }
                }
                .scenePadding(.horizontal)
                
                Button("Don't have an account? Register here") {
                    showRegistrationView.toggle()
                }
                .foregroundColor(.blue)
                .padding()
                
                if let errorMessage = loginViewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .padding()
            .navigationTitle("Login")
            .sheet(isPresented: $showRegistrationView) {
                RegistrationView()
            }
        }
    }
}



#Preview {
    LoginView()
}
