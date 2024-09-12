//
//  User.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 12.09.2024.
//


struct User {
    var id: String
    var email: String
    var isEmailVerified: Bool
    
    init(id: String, email: String, isEmailVerified: Bool = false) {
        self.id = id
        self.email = email
        self.isEmailVerified = isEmailVerified
    }
}
