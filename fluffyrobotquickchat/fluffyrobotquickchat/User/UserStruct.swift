//
//  User.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/28/24.
//

import Foundation

struct UserDoc: Codable {
    @DocumentID var email: String?
    var name: String
}
