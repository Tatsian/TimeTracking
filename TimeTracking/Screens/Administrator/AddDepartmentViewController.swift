//
//  AddDepartmentViewController.swift
//  TimeTracking
//
//  Created by Tatsiana on 20.05.2020.
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
                                                           action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                           target: self,
                                                           action: #selector(saveTapped))
        
        if let openedDepartment = department {
            departmentNameTextField.text = openedDepartment.name
            navigationItem.title = "Department detail"
        }
    }

    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped() {
        let name = departmentNameTextField.text ?? ""
        if name.isEmpty {
            departmentNameTextField.setRedPlaceholder()
            UIAlertController.showAlert(message: "Missing required field", from: self)
        } else if checkingTheSame(name: name) {
            UIAlertController.showAlert(message: "A department with that name already exists", from: self)
        } else {
            
            if department == nil {
                department = CoreDataManager.shared.newDepartment()
            }
            department?.name = name
            CoreDataManager.shared.save()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func checkingTheSame(name: String) -> Bool  {
        let departmentsArray = CoreDataManager.shared.getDepartmentsList()
        let filter = departmentsArray.filter { $0 != department }
        for dep in filter {
            if dep.name == name {
                return true
            }
        }
        return false
    }
}
