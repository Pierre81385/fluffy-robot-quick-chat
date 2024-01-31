//
//  FirebaseAuth.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/15/24.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct FireAuthStatus {
    var success: Bool
    var code: Int
    var message: String
}

struct FireAuth {
    @Binding var authStatus: FireAuthStatus
    
    func CreateUser(username: String, email: String, password: String) {
          Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                authStatus.success = false
                authStatus.code = 500
                authStatus.message = error?.localizedDescription ?? ""
            } else {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges { error in
                    if error != nil {
                        authStatus.success = false
                        authStatus.code = 500
                        authStatus.message = error?.localizedDescription ?? ""
                    } else {
                        authStatus.success = true
                        authStatus.code = 200
                        authStatus.message = "User created!"
                    }
                }
                
            }
        }
    }
    
    func GetCurrentUser() -> User {
        if Auth.auth().currentUser != nil {
            authStatus.success = true
            authStatus.code = 200
            authStatus.message = "Found user uid: \(String(describing: Auth.auth().currentUser?.uid))"
            return Auth.auth().currentUser!
        } else {
            authStatus.success = false
            authStatus.code = 500
            authStatus.message = "The current user is signed out!"
            return Auth.auth().currentUser!
        }
    }
    
    func SignInWithEmailAndPassword(email: String, password: String) {
        
               Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                   if error != nil {
                       authStatus.success = false
                       authStatus.code = 500
                       authStatus.message = error?.localizedDescription ?? ""
                   } else {
                       authStatus.success = true
                       authStatus.code = 200
                       authStatus.message = "Successfully signed in!"
                   }
               }
           
    }
    
    func SendEmailVerfication(){
        Auth.auth().currentUser?.sendEmailVerification { error in
            if error != nil {
                authStatus.success = false
                authStatus.code = 500
                authStatus.message = error?.localizedDescription ?? ""
            } else {
                authStatus.success = true
                authStatus.code = 200
                authStatus.message = "Email verification sent!"
            }
        }
    }
    
    func UpdateEmail(email: String) {
        Auth.auth().currentUser?.sendEmailVerification(beforeUpdatingEmail: email) { error in
            if error != nil {
                authStatus.success = false
                authStatus.code = 500
                authStatus.message = error?.localizedDescription ?? ""
            } else {
                authStatus.success = true
                authStatus.code = 200
                authStatus.message = "Email updated!"
            }
        }
    }
    
    func UpdatePassword(password: String) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            if error != nil {
                authStatus.success = false
                authStatus.code = 500
                authStatus.message = error?.localizedDescription ?? ""
            } else {
                authStatus.success = true
                authStatus.code = 200
                authStatus.message = "Password updated!"
            }
        }
    }
    
    func SendPasswordReset(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                authStatus.success = false
                authStatus.code = 500
                authStatus.message = error?.localizedDescription ?? ""
            } else {
                authStatus.success = true
                authStatus.code = 200
                authStatus.message = "Password reset sent to \(email)!"
            }
        }
    }
    
    func DeleteCurrentUser() {
        let user = Auth.auth().currentUser

        user?.delete { error in
            if error != nil {
                authStatus.success = false
                authStatus.code = 500
                authStatus.message = error?.localizedDescription ?? ""
            } else {
                authStatus.success = true
                authStatus.code = 200
                authStatus.message = "User deleted!"
            }
        }
    }
    
    func SignOut(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            authStatus.success = true
            authStatus.code = 200
            authStatus.message = "Signed out!"
        } catch let signOutError as NSError {
            authStatus.success = false
            authStatus.code = 500
            authStatus.message = signOutError.description
        }
    }
}
