//
//  User.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/28/24.
//

import Foundation
import FirebaseFirestore

struct UserDoc: Codable, Identifiable {
    var id: String = UUID().uuidString
    var email: String
    var name: String
}
