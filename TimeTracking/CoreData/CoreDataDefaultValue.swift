//
//  CoreDataDefaultValue.swift
//  TimeTracking
//
//  Created by Tatsiana on 24.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import CoreData

class CoreDataDefaultValue {
    
    static let context = CoreDataManager.shared.context
    
    static func addDefaultValues() {
        
        let depart = Departments(context: context)
        depart.name = "Administrative"
        
        let depart2 = Departments(context: context)
        depart2.name = "Developer"
        
        let depArray = CoreDataManager.shared.getDepartmentsList()
        
        let employee = Employees(context: context)
        employee.firstName = "Tatsiana"
        employee.lastName = "Pasiukova"
        employee.position = "iOS developer"
        employee.salary = 100
        employee.department = depArray.last
        
        let employee2 = Employees(context: context)
        employee2.firstName = "Petrov"
        employee2.lastName = "Sergey"
        employee2.position = "Python developer"
        employee2.salary = 1000
        
        let dayType = TypeOfDays(context: context)
        dayType.type = "Б"
        dayType.typeFullName = "Дни временной нетрудоспособности"
        
        let dayType2 = TypeOfDays(context: context)
        dayType2.type = "В"
        dayType2.typeFullName = "Выходные и праздничные дни"
        
        let dayType3 = TypeOfDays(context: context)
        dayType3.type = "Хд"
        dayType3.typeFullName = "Хозяйственный день"
        
        let dayType4 = TypeOfDays(context: context)
        dayType4.type = "У"
        dayType4.typeFullName = "Отпуск на период обучения"
        
        CoreDataManager.shared.save()
    }
}
