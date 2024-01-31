//
//  ItemList.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/29/24.
//


import Foundation
import SwiftUI

struct ItemListView: View {
    
    let items: [Item] = [
        Item(name: "Coors Lite", description: "Colorado light beer availible in bootle and draft.", instock: true, quantity: 0, price: 4.0, category: Categories.drinks_beer, dietary: Restrictions.none, discount: 0.0),
        Item(name: "Great Divide - Yeti", description: "Colorado microbrew beer.", instock: true, quantity: 0, price: 6.0, category: Categories.drinks_beer, dietary: Restrictions.none, discount: 0.0)
    ]
        
    var body: some View {
        NavigationView {
            List(items) {
                item in
                VStack {
                    Text(item.name)
                        .font(.headline)
                    Text(item.description)
                }
            }
        }.navigationTitle("Users")
            .onAppear {
                //items.fetchData()
            }
    }
}

struct ItemListView_Preview: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
