//
//  new_notesApp.swift
//  new notes
//
//  Created by Monika Suresh Ilamkar on 14/11/25.
//

import SwiftUI
import SwiftData

@main
struct new_notesApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Note.self,
            Profile.self
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
            ContentView()
                .preferredColorScheme(.light)
                .tint(.appPink)
                .background(Color.appPink.opacity(0.05))
        }
        .modelContainer(sharedModelContainer)
    }
}

