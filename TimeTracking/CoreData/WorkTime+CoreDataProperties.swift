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


extension WorkTimeInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkTimeInfo> {
        return NSFetchRequest<WorkTimeInfo>(entityName: "WorkTime")
    }

    @NSManaged public var startDate: Date
    @NSManaged public var endDate: Date
    @NSManaged public var type: String
    @NSManaged public var employee: EmployeesInfo?
    @NSManaged public var daysType: TypeOfDaysInfo?

}
