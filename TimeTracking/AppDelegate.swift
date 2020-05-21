//
//  AppDelegate.swift
//  TimeTracking
//
//  Created by Tatsiana on 19.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext

//        guard let entityDescription = NSEntityDescription.entity(forEntityName: "EmployeesInfo", in: context) else {
//             return true
//         }
//         let managedObject = Employees(entity: entityDescription, insertInto: context)
//
//        managedObject.firstName = "Sergey"
//        managedObject.lastName = "Petrov"
//        managedObject.position = "Python and Go developer"
//        managedObject.salary = 100.00
//        managedObject.department?.name = "Developer"

//        managedObject.firstName = "Tatsiana"
//        managedObject.lastName = "Pasiukova"
//        managedObject.position = "iOS developer"
//        managedObject.salary = 100
//
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "DepartmentsInfo", in: context) else {
             return true
         }
         let managedObject = DepartmentsInfo(entity: entityDescription, insertInto: context)

         managedObject.name = "Developer"


         self.saveContext()

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DepartmentsInfo")
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [DepartmentsInfo] {

//                                if result.firstName == nil {
//                                    context.delete(result)
//                                    self.saveContext()
//                                }

                print("type - \(result.name)")
                //                print("full - \(result.typeFullName ?? "")")

            }
        } catch {
            print(error)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TimeTracking")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

