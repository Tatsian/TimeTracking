//
//  AddPersonViewController.swift
//  TimeTracking
//
//  Created by Tatsiana on 20.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var positionTextField: UITextField!
    @IBOutlet weak var salaryTextField: UITextField!
    @IBOutlet weak var departmentPicker: UIPickerView!
    
    
    var employee: EmployeesInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                           target: self,
                                                           action: #selector(saveTapped))
        
        if let openedEmployee = employee {
            firstNameTextField.text = openedEmployee.firstName
            lastNameTextField.text = openedEmployee.lastName
            positionTextField.text = openedEmployee.position
            salaryTextField.text = "\(openedEmployee.salary)"
            navigationItem.title = "Employee detail"
        }
    }
    
    

    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped() {
        let name = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let position = positionTextField.text ?? ""
        
        guard let salary = Decimal(string: salaryTextField.text ?? "") else {
            UIAlertController.showAlert(message: "hui", from: self)
            return
        }
        
        if name.isEmpty || lastName.isEmpty || position.isEmpty {
            UIAlertController.showAlert(message: "Missing required field(s)", from: self)
        } else {
            let newEmployee = Employee(firstName: name,
                                       lastName: lastName,
                                       position: position,
                                       salary: salary)
            CoreDataManager.shared.save(employee: newEmployee, oldValue: employee)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension AddEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let departments = CoreDataManager.shared.getDepartmentsList()
        return departments.count
    }
    

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let departments = CoreDataManager.shared.getDepartmentsList()[row]
        return departments.name
    }
    
}
