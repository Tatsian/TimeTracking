//
//  Departments+CoreDataProperties.swift
//  TimeTracking
//
//  Created by Tatsiana on 20.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//
//

import Foundation
import CoreData


extension Departments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Departments> {
        return NSFetchRequest<Departments>(entityName: "Departments")
    }

    @NSManaged public var name: String
    @NSManaged public var employees: NSSet?

}

// MARK: Generated accessors for employees
extension Departments {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employees)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employees)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}
