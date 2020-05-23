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
    
    func getDepartmentsList() -> [Departments] {
        let fetchRequest = Departments.fetchRequest() as NSFetchRequest<Departments>
        let sort = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
           return try context.fetch(fetchRequest)
        } catch let error {
            print("Could not fetch because of error: \(error)")
            return []
        }
    }
    
    func getEmployeesList() -> [Employees] {
        let fetchRequest = Employees.fetchRequest() as NSFetchRequest<Employees>
        let sort = NSSortDescriptor(key: "lastName", ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
           return try context.fetch(fetchRequest)
        } catch let error {
            print("Could not fetch because of error: \(error)")
            return []
        }
    }
    
    func getTypeOfDays() -> [TypeOfDays] {
        let fetchRequest = TypeOfDays.fetchRequest() as NSFetchRequest<TypeOfDays>
        do {
           return try context.fetch(fetchRequest)
        } catch let error {
            print("Could not fetch because of error: \(error)")
            return []
        }
    }
    
//    func save(department: String, oldValue: Departments? = nil ) {
//        let newDepartment = oldValue ?? Departments(context: context)
//        newDepartment.name = department
//        do {
//            try context.save()
//        } catch let error {
//            print("Could not save because of error: \(error)")
//        }
//    }
    
    func newEmployee() -> Employees {
        return Employees(context: context)
    }
    func newDepartment() -> Departments {
        return Departments(context: context)
    }
    
    func save() {

        do {
            try context.save()
        } catch let error {
            print("Could not save because of error: \(error)")
        }
    }
    
    func delete(department: Departments) {
        context.delete(department)
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error)")
        }
    }
    
    func delete(employee: Employees) {
        context.delete(employee)
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error)")
        }
    }
}

