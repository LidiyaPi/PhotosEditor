//
//  GalleryView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 13.09.2024.
//

import SwiftUI
import PhotosUI
import PencilKit
import CoreImage
import CoreImage.CIFilterBuiltins

struct GalleryView: View {
    @StateObject private var viewModel = GalleryViewModel()
    
    var body: some View {
        VStack {
            if let selectedImage = viewModel.selectedImage {
                selectedImage
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(viewModel.scale)
                    .rotationEffect(viewModel.angle)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                viewModel.scale = value
                            }
                            .simultaneously(
                                with: RotationGesture()
                                    .onChanged { value in
                                        viewModel.angle = value
                                    }
                            )
                    )
                
                if !viewModel.textOverlay.isEmpty {
                    Text(viewModel.textOverlay)
                        .font(viewModel.textFont)
                        .foregroundColor(viewModel.textColor)
                        .padding()
                }
                
            } else {
                Spacer()
                Text("Нет выбранного изображения")
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    viewModel.sourceType = .photoLibrary
                    viewModel.isShowingImagePicker = true
                }) {
                    Image(systemName: "photo.on.rectangle")
                    Text("Выбрать из библиотеки")
                }
                
                Button(action: {
                    viewModel.sourceType = .camera
                    viewModel.isShowingImagePicker = true
                }) {
                    Image(systemName: "camera")
                    Text("Сделать фото")
                }
                
                Button(action: {
                    viewModel.showTextEditor = true
                }) {
                    Image(systemName: "textformat")
                    Text("Добавить текст")
                }
                
                Button(action: {
                    viewModel.applyFilter()
                }) {
                    Text("Применить фильтр")
                }
            }
        }
        .padding()
        .sheet(isPresented: $viewModel.isShowingImagePicker) {
            ImagePicker(selectedImage: $viewModel.selectedImage, isShown: $viewModel.isShowingImagePicker, sourceType: viewModel.sourceType)
        }
        .sheet(isPresented: $viewModel.showTextEditor) {
            TextEditorView(text: $viewModel.textOverlay,
                           font: $viewModel.textFont,
                           color: $viewModel.textColor,
                           showTextEditor: $viewModel.showTextEditor)
        }
    }
}

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

#Preview {
    GalleryView()
}
