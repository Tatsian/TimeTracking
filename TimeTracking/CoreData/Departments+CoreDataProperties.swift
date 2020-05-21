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


extension DepartmentsInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DepartmentsInfo> {
        return NSFetchRequest<DepartmentsInfo>(entityName: "Departments")
    }

    @NSManaged public var name: String
    @NSManaged public var employees: NSSet?

}

// MARK: Generated accessors for employees
extension DepartmentsInfo {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: EmployeesInfo)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: EmployeesInfo)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}
