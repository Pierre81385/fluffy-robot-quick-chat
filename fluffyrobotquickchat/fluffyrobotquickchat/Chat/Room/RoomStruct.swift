//
//  RoomStruct.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/2/24.
//

import Foundation
import FirebaseFirestore

struct Room: Codable, Identifiable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var description: String
    var createdBy: String
    var isPrivate: Bool
    //var messages: [Message]
    var users: [UserDoc]
}
