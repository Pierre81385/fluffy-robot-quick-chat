//
//  ItemViewModel.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/28/24.
//

import SwiftUI
import FirebaseFirestore

class ItemModel: ObservableObject {
    @Published var items = [Item]()
    
    private var db = Firestore.firestore()
    
    func fetchData() {
        db.collection("items").addSnapshotListener({(QuerySnapshot, error) in
        
            guard let documents = QuerySnapshot?.documents else {
                print("No items")
                return
            }
            
            self.items = documents.map {
                (QueryDocumentSnapshot) -> Item in
                let data = QueryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let instock = data["instock"] as? Bool ?? false
                let quantity = data["quantity"] as? Int ?? 0
                let price = data["price"] as? Double ?? 0.0
                let category = data["category"] as? Categories ?? Categories.none
                let dietary = data["dietary"] as? Restrictions ?? Restrictions.none
                let discount = data["discount"] as? Double ?? 0.0
                return Item(name: name, description: description, instock: instock, quantity: quantity, price: price, category: category, dietary: dietary, discount: discount)
            }
            
        })
    }
}
