//
//  matchmateApp.swift
//  matchmate
//
//  Created by Vaibhav Bhatt on 13/07/24.
//

import SwiftUI

@main
struct matchmateApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
