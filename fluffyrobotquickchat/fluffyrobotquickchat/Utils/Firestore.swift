//
//  Firestore.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

struct FirestoreStatus {
    var success: Bool
    var code: Int
    var message: String
}

struct FirestoreUser {
    
    @Binding var user: StoredUser
    @Binding var status: FirestoreStatus
   
    let db = Firestore.firestore()
    
    func createNewUser () async {
        
        do {
            try await db.collection("users").document(user.email).setData([
            "email": user.email,
          ])
            status.success = true
            status.code = 200
            status.message = "New User document successfully written!"
        } catch {
            status.success = false
            status.code = 500
            status.message = "Error writing User document: \(error)"
        }
    }
    
    func getUser () {
        let docRef = db.collection("users").document(user.email)
         docRef.getDocument { (document, error) in
                if let document = document, document.exists {
                    user = StoredUser(snapshot: document)
                    status.success = true
                    status.code = 200
                    status.message = "Found user: \(user.email)"
                } else {
                    status.success = false
                    status.code = 500
                    status.message = "Error: \(String(describing: error))"
                }
            }
    }
}

struct FirestoreChat {
    
    @Binding var room: StoredChatroom
    @Binding var status: FirestoreStatus
    
    let db = Firestore.firestore()
    
     func createNewChatRoom (email: String) async {
         let id = db.collection("chatRooms").document().documentID
        
         do {
            try await db.collection("chatRooms").document(id).setData([
            "createdBy": email,
            "roomName": room.roomName,
            "isPrivate": room.isPrivate,
            "users": room.users,
            "messages": room.messages
          ])
             try await db.collection("users").document(email).updateData(["rooms": FieldValue.arrayUnion([id])])
            status.success = true
            status.code = 200
            status.message = "Chatroom \(room.roomName) created!"
        } catch {
            status.success = false
            status.code = 500
            status.message = "Error: \(String(describing: error))"
        }
    }
}



