//
//  budgetApp.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-01.
//

import SwiftUI

@main
struct budgetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
