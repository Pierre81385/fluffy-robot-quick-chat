//
//  Firestore.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import Foundation
import FirebaseFirestore



struct FirestoreUser {
   
    let db = Firestore.firestore()

    func createNewUser (email: String, password: String) async {
        do {
          try await db.collection("users").document(email).setData([
            "email": email,
            "password": password,
          ])
          print("Document successfully written!")
        } catch {
          print("Error writing document: \(error)")
        }
    }
    
}
