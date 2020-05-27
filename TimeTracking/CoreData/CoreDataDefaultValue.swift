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
        
        let employee = Employees(context: context)
        employee.firstName = "Tatsiana"
        employee.lastName = "Pasiukova"
        employee.position = "iOS developer"
        employee.salary = 100
        employee.department = depart
        
        let dayTypes = [
            "Б" : "Дни временной нетрудоспособности",
            "В" : "Выходные и праздничные дни",
            "К" : "Командировочные дни",
            "У" : "Отпуск на период обучения",
            "До" : "Неоплачиваемый отпуск ",
            "ОТ" : "Ежегодный основной оплаченный отпуск",
            "Хд" : "Хозяйственный день"
        ]

        for (key, value) in dayTypes {
            let dayType = TypeOfDays(context: context)
            dayType.type = key
            dayType.typeFullName = value
        }
         CoreDataManager.shared.save()
    }
}
