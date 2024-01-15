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

struct FireAuth {
    
    func CreateUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    func SignInWithEmailAndPassword(email: String, password: String) {
        
               Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                   if error != nil {
                       print(error?.localizedDescription ?? "")
                   } else {
                       print("success")
                   }
               }
           
    }
    
    func SendEmailVerfication(){
        Auth.auth().currentUser?.sendEmailVerification { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    func UpdateEmail(email: String) {
        Auth.auth().currentUser?.sendEmailVerification(beforeUpdatingEmail: email) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    func UpdatePassword(password: String) {
        Auth.auth().currentUser?.updatePassword(to: password) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    func SendPasswordReset(email: String){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    func DeleteCurrentUser() {
        let user = Auth.auth().currentUser

        user?.delete { error in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                print("success")
            }
        }
    }
    
    func SignOut(){
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
