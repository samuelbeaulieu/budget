//
//  Transaction+CoreDataProperties.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-02-04.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: NSDecimalNumber
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var timestamp: Date
    @NSManaged public var type: Int32
    @NSManaged public var category: Category
    @NSManaged public var accountTo: Account
    @NSManaged public var accountFrom: Account

}

extension Transaction : Identifiable {

}

enum TransactionType: Int32, CaseIterable {
    case income
    case expense
    case transfer

    var displayString: String {
        switch self {
        case .expense:
            return "Expense"
        case .income:
            return "Income"
        case .transfer:
            return "Transfer"
        }
    }
}
