//
//  Category+CoreDataProperties.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-02-04.
//
//

import Foundation
import CoreData

extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var type: Int32
    @NSManaged public var ofTransaction: Transaction

}

extension Category : Identifiable {

}

enum CategoryType: Int32, CaseIterable {
    case income
    case expense
    
    var displayString: String {
        switch self {
        case .expense:
            return "Expenses"
        case .income:
            return "Income"
        }
    }
}
