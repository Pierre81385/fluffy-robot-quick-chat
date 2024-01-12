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


@main
struct fluffyrobotquickchatApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
       
    @UIApplicationDelegateAdaptor(MyAppDelegate.self) var delegate

    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
