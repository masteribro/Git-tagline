//
//  git_profileApp.swift
//  git_profile
//
//  Created by Ibrahim Mohammed on 26/04/2025.
//

import SwiftUI
import SwiftData

@main
struct git_profileApp: App {
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

    var body: some Scene {
        WindowGroup {
            LoginPage()
        }
        .modelContainer(sharedModelContainer)
    }
}
