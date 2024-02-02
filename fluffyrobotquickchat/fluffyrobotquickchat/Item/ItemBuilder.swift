//
//  ItemBuilder.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 2/2/24.
//

import SwiftUI

struct ItemBuilder: View {

    @State var name: String = ""
    @State var description: String = ""
    @State var instock: Bool = true
    @State var selectetCategory: Categories = .none
    @State var selectedRestriction: Restrictions = .none
    @State var submit: Bool = false
    @ObservedObject private var item: ItemModel = ItemModel.init(items: [], item: Item(name: "", description: "", instock: false, quantity: 0, price: 0.0, categories: "", dietary: "", discount: 0.0), errorMessage: "")
    
    
    var body: some View {
        ZStack {
            Color(Color.offWhite)
            VStack {
                Text("Name")
                TextField("name", text: $name)
                    .accentColor(.black)
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                Text("Description")
                TextField("description", text: $description)
                    .accentColor(.black)
                    .padding()
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    .autocorrectionDisabled()
                
                HStack {
                    VStack {
                        Text("Item Category")
                        Picker("", selection: $selectetCategory) {
                            ForEach(Categories.allCases) { option in
                                Text(option.rawValue)
                            }
                        }
                        .pickerStyle(.wheel)
                        .tint(.black)
                    }.padding()
                    Spacer()
                    VStack {
                        Text("Dietary Restrictions")
                        Picker("", selection: $selectedRestriction) {
                            ForEach(Restrictions.allCases) { option in
                                Text(option.rawValue)
                            }
                        }
                        .pickerStyle(.wheel)
                        .tint(.black)
                    }.padding()
                }
                Toggle(isOn: $instock) {
                        Text("In Stock")
                }.padding()
                Button(action: {
                    let newItem: Item = Item(name: name, description: description, instock: instock, quantity: 0, price: 0.0, categories: selectetCategory.rawValue, dietary: selectedRestriction.rawValue, discount: 0.0)
                    
                    item.addItem(item: newItem)
                    
                    
                }, label: {
                    Text("SUBMIT")
                }).buttonStyle(NeumorphicButton(shape: RoundedRectangle(cornerRadius: 10)))
                    .padding()
                    .navigationDestination(isPresented: $submit, destination: {UserProfileView()})
            }
        }.ignoresSafeArea()
    }
    
}

#Preview {
    ItemBuilder()
}
