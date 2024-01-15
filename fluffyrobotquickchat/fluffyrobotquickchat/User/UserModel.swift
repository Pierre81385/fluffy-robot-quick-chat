//
//  UserModel.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/14/24.
//

import SwiftUI
import FirebaseFirestore
import Firebase

final class StoredUser: Codable {
    var email: String
    var password: String
    var avatarImage: String
    var bio: String
    var friends: Array<StoredUser>
    var rooms: Array<StoredChatroom>
    var favorites: Array<StoredChatroom>
    var documentId: String?
    
    init(email: String, password: String, avatarImage: String, bio: String, friends: Array<StoredUser>, rooms: Array<StoredChatroom>, favorites: Array<StoredChatroom>) {
        self.email = email
        self.password = password
        self.avatarImage = avatarImage
        self.bio = bio
        self.friends = friends
        self.rooms = rooms
        self.favorites = favorites
    }
    
    var dictionary : [String:Any] {
            return [
                    "email": email,
                    "password": password,
                    "avatarImage": avatarImage,
                    "bio": bio,
                    "friends": friends,
                    "rooms": rooms,
                    "favorites": favorites
            ]
        }
    
    init(snapshot: DocumentSnapshot) {
            documentId = snapshot.documentID
            let snapshotValue = snapshot.data()
            email = snapshotValue!["email"] as! String
            password = snapshotValue!["password"] as! String
            avatarImage = snapshotValue!["avatarImage"] as! String
            bio = snapshotValue!["bio"] as! String
            friends = snapshotValue!["friends"] as! Array<StoredUser>
            rooms = snapshotValue!["rooms"] as! Array<StoredChatroom>
            favorites = snapshotValue!["favorites"] as! Array<StoredChatroom>
        }

}
