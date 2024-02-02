//
//  ItemList.swift
//  fluffyrobotquickchat/Users/peterbishop/Development/fluffy-robot-quick-chat/fluffyrobotquickchat/fluffyrobotquickchat/User/UsersListView.swift
//
//  Created by Peter Bishop on 1/29/24.
//


import Foundation
import SwiftUI

struct ItemListView: View {
    
    @ObservedObject private var items: ItemModel = ItemModel.init(items: [], item: Item(name: "", description: "", instock: false, quantity: 0, price: 0.0, categories: "", dietary: "", discount: 0.0), errorMessage: "")
    
//    let items: [Item] = [
//        Item(name: "Coors Lite", description: "Colorado light beer availible in bootle and draft.", instock: true, quantity: 0, price: 4.0, categories: Categories.drinks_beer.rawValue, dietary: Restrictions.none.rawValue, discount: 0.0),
//        Item(name: "Great Divide - Yeti", description: "Colorado microbrew beer.", instock: true, quantity: 0, price: 6.0, categories: Categories.drinks_beer.rawValue, dietary: Restrictions.none.rawValue, discount: 0.0)
//    ]
        
    var body: some View {
        NavigationView {
            List(items.items) {
                item in
                VStack {
                    Text(item.name)
                        .font(.headline)
                    Text(item.description)
                }
            }
        }.navigationTitle("Users")
            .onAppear {
                items.fetchItems()
            }
    }
}

struct ItemListView_Preview: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
