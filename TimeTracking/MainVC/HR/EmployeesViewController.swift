//
//  HRViewController.swift
//  TimeTracking
//
//  Created by Tatsiana on 20.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

class EmployeesViewController: UIViewController {
    
    @IBOutlet weak var employeesTable: UITableView!
    @IBOutlet weak var addNewEmployeeButton: UIBarButtonItem!
    
    static var isHRManager = true
    
    var employeesArray = [Employees]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !EmployeesViewController.isHRManager {
            addNewEmployeeButton.isEnabled = false
            addNewEmployeeButton.tintColor = .clear
        }
        
        employeesArray = CoreDataManager.shared.getEmployeesList()
        employeesTable.reloadData()
    }
    
    static func storyboardInstance() -> AddEmployeeViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddEmployeesVC")
            as? AddEmployeeViewController
    }
    
    static func storyboardInstanceTime() -> TimeStampViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "TimeStampVC") as? TimeStampViewController
    }
    
      }

      extension EmployeesViewController: UITableViewDelegate, UITableViewDataSource {
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return employeesArray.count
          }
          
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = employeesTable.dequeueReusableCell(withIdentifier: "EmployeeCell", for: indexPath)
            let persons = employeesArray[indexPath.row]
            let name = persons.firstName 
            let lastName = persons.lastName
            cell.textLabel?.text = lastName + " " + name
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            if EmployeesViewController.isHRManager {
                
                guard let openedVC = EmployeesViewController.storyboardInstance() else {
                    return
                }
                openedVC.employee = employeesArray[indexPath.row]
                let navigationController = UINavigationController(rootViewController: openedVC)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            } else {
                guard let openedVC = EmployeesViewController.storyboardInstanceTime() else {
                    return
                }
                let persons = employeesArray[indexPath.row]
                openedVC.employeeName = persons.lastName + " " + persons.firstName
                let navigationController = UINavigationController(rootViewController: openedVC)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
        }
        
        func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                       forRowAt indexPath: IndexPath) {
            if employeesArray.count > indexPath.row {
                let employee = employeesArray[indexPath.row]
                employeesArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                CoreDataManager.shared.delete(employee: employee)
            }
        }
}

