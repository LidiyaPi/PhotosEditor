//
//  GalleryViewModel.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 13.09.2024.
//

import SwiftUI
import PhotosUI
import PencilKit
import CoreImage
import CoreImage.CIFilterBuiltins

@MainActor
final class GalleryViewModel: ObservableObject {
    @Published var selectedImage: Image?
    @Published var isShowingImagePicker = false
    @Published var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Published var scale: CGFloat = 1.0
    @Published var angle: Angle = .zero
    @Published var drawing = PKDrawing()
    @Published var textOverlay: String = ""
    @Published var textFont: Font = .system(size: 20)
    @Published var textColor: Color = .black
    @Published var showTextEditor = false
    
    func applyFilter() {
        // Проверяем, что selectedImage доступен
        guard let selectedImage = selectedImage else { return }
        
        // Преобразуем Image в UIImage
        guard let uiImage = toUIImage(swiftUIImage: selectedImage) else {
            print("Не удалось преобразовать Image в UIImage.")
            return
        }
        
        // Применение фильтра к изображению
        guard let ciImage = CIImage(image: uiImage) else {
            print("Не удалось создать CIImage из UIImage.")
            return
        }
        
        let filter = CIFilter.sepiaTone()
        filter.inputImage = ciImage
//        filter.intensity = 0.5
        
        // Получаем выходное изображение
        if let outputImage = filter.outputImage, let cgImage = CIContext().createCGImage(outputImage, from: outputImage.extent) {
            let filteredUIImage = UIImage(cgImage: cgImage)
            self.selectedImage = Image(uiImage: filteredUIImage)
        } else {
            print("Не удалось получить отфильтрованное изображение.")
        }
    }
    
    private func toUIImage(swiftUIImage: Image) -> UIImage? {
        let controller = UIHostingController(rootView: swiftUIImage)
        let view = controller.view
        
        let targetSize = CGSize(width: 300, height: 300)
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.sizeToFit()
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { context in
            view?.drawHierarchy(in: context.format.bounds, afterScreenUpdates: true)
        }
    }
}
