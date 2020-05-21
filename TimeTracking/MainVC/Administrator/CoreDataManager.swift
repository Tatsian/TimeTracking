//
//  CoreDataManager.swift
//  TimeTracking
//
//  Created by Tatsiana on 20.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    func getDepartmentsList() -> [DepartmentsInfo] {
        let fetchRequest = DepartmentsInfo.fetchRequest() as NSFetchRequest<DepartmentsInfo>
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
           return try context.fetch(fetchRequest)
        } catch let error {
            print("Could not fetch because of error: \(error)")
            return []
        }
    }
    
    func getEmployeesList() -> [EmployeesInfo] {
        let fetchRequest = EmployeesInfo.fetchRequest() as NSFetchRequest<EmployeesInfo>
        let sort = NSSortDescriptor(key: "lastName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
           return try context.fetch(fetchRequest)
        } catch let error {
            print("Could not fetch because of error: \(error)")
            return []
        }
    }
    
    func save(department: String, oldValue: DepartmentsInfo? = nil ) {
        let newDepartment = oldValue ?? DepartmentsInfo(context: context)
        newDepartment.name = department
        do {
            try context.save()
        } catch let error {
            print("Could not save because of error: \(error)")
        }
    }
    
    func save(employee: Employee, oldValue: EmployeesInfo? = nil ) {
        let newEmployee = oldValue ?? EmployeesInfo(context: context)
        
        newEmployee.firstName = employee.firstName
        newEmployee.lastName = employee.lastName
        newEmployee.position = employee.position
        newEmployee.salary = employee.salary
        
        do {
            try context.save()
        } catch let error {
            print("Could not save because of error: \(error)")
        }
    }
    
    func delete(department: DepartmentsInfo) {
        context.delete(department)
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error)")
        }
    }
    
    func delete(employee: EmployeesInfo) {
        context.delete(employee)
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error)")
        }
    }
}

