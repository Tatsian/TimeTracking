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
    
    let departmentsArray = CoreDataManager.shared.getDepartmentsList()
    
    var employee: Employees?
    
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
            
            setPickerDefaultValue(item: openedEmployee.department)
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
        let departmentIndex = departmentPicker.selectedRow(inComponent: 0)
        let department = departmentsArray[departmentIndex]
        
        guard let salary = Decimal(string: salaryTextField.text ?? "") else {
            UIAlertController.showAlert(message: "You can use 0-9 to set the salary value", from: self)
            setRedPlaceholder(for: firstNameTextField)
            setRedPlaceholder(for: lastNameTextField)
            setRedPlaceholder(for: positionTextField)
            setRedPlaceholder(for: salaryTextField)
            return
        }
        
        if name.isEmpty || lastName.isEmpty || position.isEmpty {
            setRedPlaceholder(for: firstNameTextField)
            setRedPlaceholder(for: lastNameTextField)
            setRedPlaceholder(for: positionTextField)
            UIAlertController.showAlert(message: "Missing required field(s)", from: self)
        } else {
            if employee == nil {
                employee = CoreDataManager.shared.newEmployee()
            }
            employee?.firstName = name.capitalized
            employee?.lastName = lastName.capitalized
            employee?.position = position
            employee?.salary = NSDecimalNumber(decimal: salary)
            employee?.department = department
  
            CoreDataManager.shared.save()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func setPickerDefaultValue(item: Departments?) {
        guard let item = item else {
            return
        }
        if let indexPosition = departmentsArray.firstIndex(of: item) {
            departmentPicker.selectRow(indexPosition, inComponent: 0, animated: true)
        }
    }
}

extension AddEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return departmentsArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let department = departmentsArray[row]
        return department.name
    }
}
