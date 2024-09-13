//
//  PhotosEditorApp.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 11.09.2024.
//

import SwiftUI
import GoogleSignIn
import Firebase

@main
struct PhotosEditorApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("signIn") var isSignIn = false
    
    var body: some Scene {
        WindowGroup {
            if isSignIn {
                GalleryView()
            } else {
                LoginView()
            }
        }
    }
}
