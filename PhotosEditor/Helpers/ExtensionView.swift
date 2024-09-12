//
//  ExtensionView.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//

import SwiftUI

extension View {
    func getRootViewController() -> UIViewController {
        
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return.init()
        }
        
        guard let root = screen.windows.first?.rootViewController else {
            return.init()
        }
        
        return root
    }
}
