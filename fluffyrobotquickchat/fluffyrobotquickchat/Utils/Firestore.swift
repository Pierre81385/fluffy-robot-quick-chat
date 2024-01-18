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



