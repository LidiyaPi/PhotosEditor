//
//  TextFieldModifier.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 14.09.2024.
//

import SwiftUI

struct CustomTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.5), radius: 2, x: 0, y: 1)
    }
}

extension View {
    func customTextFieldStyle() -> some View {
        self.modifier(CustomTextField())
    }
}
