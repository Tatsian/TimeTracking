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
          
          var employeesArray = [EmployeesInfo]()
          
          override func viewDidLoad() {
              super.viewDidLoad()

              // Do any additional setup after loading the view.
          }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        employeesArray = CoreDataManager.shared.getEmployeesList()
        employeesTable.reloadData()
    }
    
    static func storyboardInstance() -> AddEmployeeViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddEmployeesVC")
            as? AddEmployeeViewController
    }
    
      }

      extension EmployeesViewController: UITableViewDelegate, UITableViewDataSource {
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return employeesArray.count
          }
          
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = employeesTable.dequeueReusableCell(withIdentifier: "HolidaysCell", for: indexPath)
            let persons = employeesArray[indexPath.row]
            let name = persons.firstName 
            let lastName = persons.lastName
            cell.textLabel?.text = lastName + " " + name
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            guard let testVC = EmployeesViewController.storyboardInstance() else {
                return
            }
            testVC.employee = employeesArray[indexPath.row]
            let navigationController = UINavigationController(rootViewController: testVC)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true, completion: nil)
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

