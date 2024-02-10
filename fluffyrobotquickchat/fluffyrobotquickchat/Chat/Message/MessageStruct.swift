//
//  MessageStruct.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/2/24.
//

import Foundation
import FirebaseFirestore

struct Message: Codable, Identifiable {
    var id: String? = UUID().uuidString
    var senderName: String
    var senderId: String
    var sendTime: Double
    var message: String
    var read: Bool
    var readTime: Double
}
