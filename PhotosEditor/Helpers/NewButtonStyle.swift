//
//  NewButtonStyle.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//

import SwiftUI

struct NewButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.white) // Белый фон
            .foregroundColor(.black) // Цвет текста
            .cornerRadius(5) // Закругленные углы
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1) // Рамка
            )
            .frame(maxWidth: .infinity)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3) // Тень
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0) // Эффект нажатия

            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed) // Анимация нажатия
         
    }
}
