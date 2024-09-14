//
//  TextEditer.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 14.09.2024.
//

import SwiftUI

struct TextEditorView: View {
    @Binding var text: String
    @Binding var font: Font
    @Binding var color: Color
    @Binding var showTextEditor: Bool
    
    var body: some View {
        VStack {
            TextField("Введите текст", text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            ColorPicker("Выберите цвет текста", selection: $color)
                .padding()
            
            Button("Сохранить") {
                showTextEditor.toggle()
            }
            .padding()
        }
        .padding()
    }
}
