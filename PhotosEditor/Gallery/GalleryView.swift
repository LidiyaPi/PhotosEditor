//
//  GalleryView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 13.09.2024.
//

import SwiftUI

struct GalleryView: View {
    @StateObject private var viewModel = GalleryViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                if let selectedImage = viewModel.selectedImage {
                    selectedImage
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(viewModel.scale)
                        .rotationEffect(viewModel.angle)
                        .gesture(
                            RotationGesture()
                                .onChanged { value in
                                    viewModel.angle = value
                                }
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
                
                VStack {
                    Text("Масштаб: \(String(format: "%.2f", viewModel.scale))")
                    Slider(value: $viewModel.scale, in: 1...5, step: 0.1)
                        .padding()
                    
                    Text("Угол поворота: \(Int(viewModel.angle.degrees))°")
                    Slider(value: Binding(
                        get: { viewModel.angle.degrees },
                        set: { viewModel.angle = Angle(degrees: $0) }
                    ), in: 0...360, step: 1)
                    .padding()
                }
                
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
                }
            }
            .padding()
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
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
}

#Preview {
    GalleryView()
}
