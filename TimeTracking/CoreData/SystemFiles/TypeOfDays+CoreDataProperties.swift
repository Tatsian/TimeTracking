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


extension TypeOfDays {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TypeOfDays> {
        return NSFetchRequest<TypeOfDays>(entityName: "TypeOfDays")
    }

    @NSManaged public var type: String
    @NSManaged public var typeFullName: String
    @NSManaged public var absence: WorkTime?

}
