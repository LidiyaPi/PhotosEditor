//
//  RegistrationView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject private var viewModel = RegistrationViewModel()
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if viewModel.isLoading {
                ProgressView()
            } else {
                Button("Register") {
                    viewModel.register()
                    showAlert = true
                }
                
            }
        }
        .padding()
        .navigationTitle("Register")
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Registration Status"),
                message: Text(viewModel.successMessage?.description ?? viewModel.errorMessage ?? ""),
                dismissButton: .default(Text("OK")) {
                    if viewModel.successMessage != nil {
                        presentationMode.wrappedValue.dismiss()
                    }
                    viewModel.successMessage = nil
                    viewModel.errorMessage = nil
                }
            )
        }
    }
    
}

#Preview {
    RegistrationView()
}
