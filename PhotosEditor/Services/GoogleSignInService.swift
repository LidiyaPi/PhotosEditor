//
//  GoogleSignInService.swift
//  PhotosEditor
//
//  Created by Лидия Пятаева on 11.09.2024.
//

import Foundation
import GoogleSignIn
import Firebase
import FirebaseAuth

struct GoogleSignInService {
    static let share = GoogleSignInService()
    
    private init() {}
    
    func signInWithGoogle(presenting: UIViewController, completion: @escaping(Error?) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presenting) { result, error in
            guard error == nil else {
                completion(error)
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result, error in
                guard error == nil else {
                    completion(error)
                    return
                }
                print("Sign in")
                UserDefaults.standard.set(true, forKey: "signIn")
            }
        }
    }
}
