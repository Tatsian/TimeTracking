//
//  Employees+CoreDataProperties.swift
//  TimeTracking
//
//  Created by Tatsiana on 20.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeesInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeesInfo> {
        return NSFetchRequest<EmployeesInfo>(entityName: "Employees")
    }

    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var position: String
    @NSManaged public var salary: Decimal
    @NSManaged public var department: DepartmentsInfo?
    @NSManaged public var workTime: NSSet?

}

// MARK: Generated accessors for workTime
extension EmployeesInfo {

    @objc(addWorkTimeObject:)
    @NSManaged public func addToWorkTime(_ value: WorkTimeInfo)

    @objc(removeWorkTimeObject:)
    @NSManaged public func removeFromWorkTime(_ value: WorkTimeInfo)

    @objc(addWorkTime:)
    @NSManaged public func addToWorkTime(_ values: NSSet)

    @objc(removeWorkTime:)
    @NSManaged public func removeFromWorkTime(_ values: NSSet)

}
