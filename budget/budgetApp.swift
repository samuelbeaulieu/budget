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
            TabView {
                TransactionList()
                    .tabItem {
                        Label("Transactions", systemImage: "list.dash")
                    }
                CategoryList()
                    .tabItem {
                        Label("Categories", systemImage: "square.grid.2x2.fill")
                    }
                AccountList()
                    .tabItem {
                        Label("Accounts", systemImage: "briefcase.fill")
                    }
            }
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
