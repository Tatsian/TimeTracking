//
//  WorkTime+CoreDataProperties.swift
//  TimeTracking
//
//  Created by Tatsiana on 20.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//
//

import Foundation
import CoreData


extension WorkTime {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkTime> {
        return NSFetchRequest<WorkTime>(entityName: "WorkTime")
    }

    @NSManaged public var startDate: Date
    @NSManaged public var type: String
    @NSManaged public var employee: Employees?
    @NSManaged public var daysType: TypeOfDays?

}
