//
//  Persistence.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-01.
//

import CoreData
import UIKit

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let names = ["Apple One", "Desjardins Assurance Auto", "Petro-Canada", "Subway", "Paiement du prêt"]
        
        for _ in 0..<10 {
            let newTransaction = Transaction(context: viewContext)
            newTransaction.id = UUID()
            newTransaction.timestamp = Date.now.addingTimeInterval(86400 * Double.random(in: 1...7))
            newTransaction.name = names.randomElement()
            newTransaction.amount = NSDecimalNumber(floatLiteral: Double.random(in: 20...4526.58))
            newTransaction.type = Int32.random(in: 0...2)
        }
        for _ in 0..<10 {
            let newCategory = Category(context: viewContext)
            newCategory.id = UUID()
            newCategory.type = Int32.random(in: 0...1)
            newCategory.name = "Transportation"
            newCategory.foregroundColor = UIColor.blue
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "budget")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
