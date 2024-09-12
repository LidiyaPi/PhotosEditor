//
//  RegistrationView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//

import SwiftUI

struct RegistrationView: View {
    
@StateObject private var viewModel = RegistrationViewModel()
    
    var body: some View {
        VStack {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.emailAddress)
                .padding()
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                              .padding()
            
            Button("Register") {
                viewModel.register()
                
            }
            .padding(EdgeInsets())
        }
//        .alert("Error", isPresented: true?, actions: {}, message: "")
    }
}

#Preview {
    RegistrationView()
}
