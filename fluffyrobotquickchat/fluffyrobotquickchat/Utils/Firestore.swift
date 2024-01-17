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

struct FirebaseStatus {
    var success: Bool
    var code: Int
    var message: String
}

struct FirestoreUser {
    
    @Binding var user: StoredUser
    @Binding var status: FirebaseStatus
   
    let db = Firestore.firestore()
    
    func createNewUser () async {
        //StoredUser(email: "", avatarImage: "", bio: "", friends: [], rooms: [], favorites: [])
        do {
            try await db.collection("users").document(user.email).setData([
            "email": user.email,
            "avatarImage": user.avatarImage,
            "bio": user.bio,
            "friends": user.friends,
            "rooms": user.rooms,
            "favorites": user.favorites
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
    @Binding var status: FirebaseStatus
    
    let db = Firestore.firestore()
    
     func createNewChatRoom () async {
         let id = db.collection("chatRooms").document().documentID
        
         do {
            try await db.collection("chatRooms").document(id).setData([
            "createdBy": room.createedBy,
            "roomName": room.roomName,
            "roomDescription": room.roomDescription,
            "isPrivate": room.isPrivate,
            "code": room.code,
            "users": room.users,
            "messages": room.messages
          ])
             try await db.collection("users").document(room.createedBy).updateData(["rooms": FieldValue.arrayUnion([id])])
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



