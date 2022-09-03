//
//  MechBoardApp.swift
//  MechBoard
//
//  Created by Timmy Nguyen on 9/2/22.
//

import SwiftUI

@main
struct MechBoardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}