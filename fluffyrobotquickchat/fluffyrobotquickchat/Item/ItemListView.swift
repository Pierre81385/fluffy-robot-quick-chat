//
//  ItemList.swift
//  fluffyrobotquickchat/Users/peterbishop/Development/fluffy-robot-quick-chat/fluffyrobotquickchat/fluffyrobotquickchat/User/UsersListView.swift
//
//  Created by Peter Bishop on 1/29/24.
//


import Foundation
import SwiftUI

struct ItemListView: View {
    
    @ObservedObject private var item: ItemModel = ItemModel.init(items: [], item: Item(name: "", description: "", instock: false, quantity: 0, price: 0.0, categories: "", discount: 0.0), errorMessage: "")
        
    var body: some View {
        NavigationView {
            List(item.items) {
                item in
                VStack {
                    Text(item.name)
                        .font(.headline)
                    Text(item.id ?? "")
                }
            }
        }.navigationTitle("Users")
            .onAppear {
                item.fetchItems()
            }
    }
}

struct ItemListView_Preview: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
