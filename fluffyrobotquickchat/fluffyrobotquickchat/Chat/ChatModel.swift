//
//  ChatModel.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/14/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import Firebase

//  firebase.firestore.FieldValue.serverTimestamp() for Timestamp
//const db = firebase.firestore();
//const ref = db.collection('your_collection_name').doc();
//const id = ref.id;

final class StoredMessage: Codable {
    var from: String
    var to: String
    var message: String
    var read: Bool
    var timeSent: Timestamp
    var documentId: String?
    
    init(from: String, to: String, message: String, read: Bool, timeSent: Timestamp) {
        self.from = from
        self.to = to
        self.message = message
        self.read = read
        self.timeSent = timeSent
    }
    
    var dictonary : [String:Any] {
        return [
            "from": from,
            "to": to,
            "message": message,
            "read": read,
            "timeSent": timeSent
        ]
    }
    
    init(snapshot: DocumentSnapshot) {
        documentId = snapshot.documentID
        let snapshotValue = snapshot.data()
        from = snapshotValue!["from"] as! String
        to = snapshotValue!["to"] as! String
        message = snapshotValue!["message"] as! String
        read = snapshotValue!["read"] as! Bool
        timeSent = snapshotValue!["timeSent"] as! Timestamp

    }
}

final class StoredChatroom: Codable {
    var createedBy: String
    var roomName: String
    var isPrivate: Bool
    var users: Array<StoredUser>
    var messages: Array<StoredMessage>
    var documentId: String?
    
    init(createdBy: String, roomName: String, isPrivate: Bool, users: Array<StoredUser>, messages: Array<StoredMessage>) {
        self.createedBy = createdBy
        self.roomName = roomName
        self.isPrivate = isPrivate
        self.users = users
        self.messages = messages
    }
    
    var dictionary : [String:Any] {
            return [
                    "createdBy": createedBy,
                    "roomName": roomName,
                    "isPrivate": isPrivate,
                    "users": users,
                    "messages": messages,
            ]
        }
    
    init(snapshot: DocumentSnapshot) {
        documentId = snapshot.documentID
        let snapshotValue = snapshot.data()
        createedBy = snapshotValue!["createedBy"] as! String
        roomName = snapshotValue!["roomName"] as! String
        isPrivate = snapshotValue!["isPrivate"] as! Bool
        users = snapshotValue!["users"] as! Array<StoredUser>
        messages = snapshotValue!["messages"] as! Array<StoredMessage>
        }

}
