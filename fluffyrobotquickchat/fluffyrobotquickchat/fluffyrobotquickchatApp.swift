//
//  fluffyrobotquickchatApp.swift
//  fluffyrobotquickchat
//
//  Created by Peter Bishop on 1/12/24.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
struct fluffyrobotquickchatApp: App {
       
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var delegate

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
