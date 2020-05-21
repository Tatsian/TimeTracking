//
//  TypeOfDays+CoreDataProperties.swift
//  TimeTracking
//
//  Created by Tatsiana on 20.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//
//

import Foundation
import CoreData


extension TypeOfDaysInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TypeOfDaysInfo> {
        return NSFetchRequest<TypeOfDaysInfo>(entityName: "TypeOfDays")
    }

    @NSManaged public var type: String
    @NSManaged public var typeFullName: String
    @NSManaged public var absence: WorkTimeInfo?

}
