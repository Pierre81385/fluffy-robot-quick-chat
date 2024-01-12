//
//  ContentView.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import SwiftUI
import SwiftData


struct ContentView: View {

    var body: some View {
        LoginView()
        RegisterView()
    }
}

#Preview {
    ContentView()
        //.modelContainer(for: Item.self, inMemory: true)
}
