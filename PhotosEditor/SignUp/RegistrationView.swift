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
    
    var body: some View {
        ZStack {
            
            CloseButton(action: {
                presentationMode.wrappedValue.dismiss()
            })
            
            VStack(spacing: 24) {
                TextField("Email", text: $viewModel.email)
                    .customTextFieldStyle()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $viewModel.password)
                    .customTextFieldStyle()
                
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Button("Рагистрация") {
                        viewModel.register()
                    }
                    .buttonStyle(ButtonModifier())
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                }
            }
            .padding()
            .navigationTitle("Регистрация")
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("Статус регистрации"),
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
}

#Preview {
    RegistrationView()
}
