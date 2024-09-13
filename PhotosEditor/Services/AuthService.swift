//
//  AuthService.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 13.09.2024.
//

import Foundation
import Firebase
import FirebaseAuth
import GoogleSignIn

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
         Auth.auth().signIn(withEmail: email, password: password) { result, error in
             if let error = error {
                 completion(.failure(error))
             } else if let user = result?.user {
                 let userModel = User(email: user.email ?? "")
                 completion(.success(userModel))
             }
         }
     }
    
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
           Auth.auth().createUser(withEmail: email, password: password) { result, error in
               if let error = error {
                   completion(.failure(error))
               } else if let user = result?.user {
                   let userModel = User(email: user.email ?? "")
                   self.sendEmailVerification(completion: { verificationError in
                       if let verificationError = verificationError {
                           completion(.failure(verificationError))
                       } else {
                           completion(.success(userModel))
                       }
                   })
               }
           }
       }
    
    private func sendEmailVerification(completion: @escaping (Error?) -> Void) {
        Auth.auth().currentUser?.sendEmailVerification { error in
            completion(error)
        }
    }
}
