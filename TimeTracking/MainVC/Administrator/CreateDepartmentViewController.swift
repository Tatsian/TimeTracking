//
//  CreateDepartmentViewController.swift
//  TimeTracking
//
//  Created by Tatsiana on 19.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import CoreData

class AddDepartmentViewController: UIViewController {

    @IBOutlet weak var departmentNameTextField: UITextField!
   
    var department: Departments?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(dismissView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                           target: self,
                                                           action: #selector(saveTapped))
        
        if let openedDepartment = department {
            departmentNameTextField.text = openedDepartment.name
            navigationItem.title = "Department detail"
        }
    }

    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped() {
        let name = departmentNameTextField.text ?? ""
        if name.isEmpty {
            showAlert(message: "Missing required field")
        } else if checkingTheSame(name: name) {
            showAlert(message: "A department with that name already exists")
        } else {
            CoreDataManager.shared.save(department: name.capitalized, oldValue: department)
            dismissView()
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error!",
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok",
                                   style: .default,
                                   handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func checkingTheSame(name: String) -> Bool  {
        let departmentsArray = CoreDataManager.shared.getDepartmentsList()
        let context = CoreDataManager.shared.context
        for dep in departmentsArray {
            if dep.name == name && context.hasChanges {
                return true
            }
        }
        return false
    }
}
