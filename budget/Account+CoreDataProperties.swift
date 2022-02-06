//
//  Account+CoreDataProperties.swift
//  budget
//
//  Created by Samuel Beaulieu on 2022-02-05.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var ofTransaction: Transaction

}

extension Account : Identifiable {

}
