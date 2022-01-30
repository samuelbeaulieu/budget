//
//  Category+CoreDataProperties.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-01-16.
//
//

import Foundation
import CoreData
import UIKit.UIColor


extension Category: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var foregroundColor: UIColor
    @NSManaged public var id: UUID?
    @NSManaged public var name: String
    @NSManaged public var type: Int32

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
