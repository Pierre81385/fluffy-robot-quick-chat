//
//  Item.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/28/24.
//


import Foundation
import FirebaseFirestore

enum Categories: String, CodingKey, CaseIterable, Identifiable, CustomStringConvertible {
    var id: Self { self }
    
    case drinks_na = "non-alcoholic drink"
    case drinks_beer = "beer"
    case drinks_cocktail = "cocktail"
    case appetizer = "appetizer"
    case entree = "main entree"
    case dessert = "dessert"
    case side = "side dish"
    case none = "none"
}

struct Item: Codable, Identifiable {
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var description: String
    var instock: Bool
    var quantity: Int
    var price: Double
    var categories: String
    var discount: Double
}
