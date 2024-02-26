//
//  User.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/28/24.
//

import Foundation
import FirebaseFirestore

enum Role: Codable {
    case Owner, Admin, Advanced, Basic
}

struct UserProfile: Codable, Identifiable {
    var id: String = UUID().uuidString
    var email: String
    var name: String
    var image: String
    var birthday: Date
    var online: Bool
    var role: Role
    var friends: [UserProfile]
}
