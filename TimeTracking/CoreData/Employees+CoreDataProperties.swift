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


extension Employees {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employees> {
        return NSFetchRequest<Employees>(entityName: "Employees")
    }

    @NSManaged public var firstName: String
    @NSManaged public var lastName: String
    @NSManaged public var position: String
    @NSManaged public var salary: NSDecimalNumber
    @NSManaged public var department: Departments?
    @NSManaged public var workTime: NSSet?

}

// MARK: Generated accessors for workTime
extension Employees {

    @objc(addWorkTimeObject:)
    @NSManaged public func addToWorkTime(_ value: WorkTime)

    @objc(removeWorkTimeObject:)
    @NSManaged public func removeFromWorkTime(_ value: WorkTime)

    @objc(addWorkTime:)
    @NSManaged public func addToWorkTime(_ values: NSSet)

    @objc(removeWorkTime:)
    @NSManaged public func removeFromWorkTime(_ values: NSSet)

}
