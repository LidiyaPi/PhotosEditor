//
//  ForgotPasswordView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 11.09.2024.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    
    @StateObject private var viewModel = ForgotPasswordViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Восстановление пароля")
                .font(.title2).bold()
                .padding()
            
            TextField("Email", text: $viewModel.email)
                .customTextFieldStyle()
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
            
            Button("Отправить ссылку на восстановление") {
                viewModel.resetPassword(email: viewModel.email)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Info"),
                message: Text(viewModel.successMessage?.description ?? viewModel.errorMessage ?? ""),
                dismissButton: .default(Text("OK")) {
                    if viewModel.successMessage != nil {
                        presentationMode.wrappedValue.dismiss()
                    }
                    //                    successMessage = nil
                    //                    errorMessage = nil
                }
            )
        }
    }
}

#Preview {
    ForgotPasswordView()
}
