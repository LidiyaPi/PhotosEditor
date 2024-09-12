//
//  PhotosEditorApp.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 11.09.2024.
//

import SwiftUI
import GoogleSignIn

@main
struct PhotosEditorApp: App {
    var body: some Scene {
        WindowGroup {
            LoginView()
//                .onOpenURL { url in
//                    GIDSignIn.sharedInstance.handle(url)
//                }
        }
    }
}
