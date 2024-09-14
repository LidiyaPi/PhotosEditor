//
//  NewButtonStyle.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//

import SwiftUI

struct ButtonModifier: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(uiColor: .systemBlue))
                    .stroke(Color.gray, lineWidth: 1)
                    .shadow(color: Color.gray, radius: 2, x: 0, y: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
        
    }
}

extension View {
    func customButtonStyle() -> some View {
        self.buttonStyle(ButtonModifier())
    }
}
