//
//  ItemList.swift
//  fluffyrobotquickchat/Users/peterbishop/Development/fluffy-robot-quick-chat/fluffyrobotquickchat/fluffyrobotquickchat/User/UsersListView.swift
//
//  Created by Peter Bishop on 1/29/24.
//


import Foundation
import SwiftUI

struct ItemListView: View {
    @State var addItem: Bool = false
    @ObservedObject private var item: ItemModel = ItemModel.init(items: [], item: Item(name: "", description: "", instock: false, quantity: 0, price: 0.0, categories: "", discount: 0.0), errorMessage: "")
        
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    addItem = true
                }, label: {
                    Text("+ Item")
                }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                    .padding()
                    .navigationDestination(isPresented: $addItem, destination: {ItemBuilder()})
                List(item.items) {
                    item in
                    VStack {
                        Text(item.name)
                            .font(.headline)
                        Text(item.id ?? "")
                    }
                }
            }
                .onAppear {
                    item.fetchItems()
                }
        }
    }
}

struct ItemListView_Preview: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
