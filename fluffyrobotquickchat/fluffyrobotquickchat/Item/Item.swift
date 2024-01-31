//
//  Item.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/28/24.
//


import Foundation

enum Categories {
    case drinks_na
    case drinks_beer
    case drinks_cocktail
    case appetizer
    case entree
    case dessert
    case side
    case none
}

enum Restrictions {
    case veg
    case nuts
    case gluten
    case vegan
    case raw
    case none
}

struct Item: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var description: String
    var instock: Bool
    var quantity: Int
    var price: Double
    var category: Categories
    var dietary: Restrictions
    var discount: Double
}
