//
//  CalendarViewController.swift
//  TimeTracking
//
//  Created by Tatsiana on 22.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {

    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var calendarView: FSCalendar!
    
    var employee: Employees?
    var daysTypeArray = CoreDataManager.shared.getTypeOfDays()
    var daysTypeTable = UITableView()
    var selectedDate = Date()
    var workTimeArray = CoreDataManager.shared.getWorkTime()
    var workTimeMark: WorkTime?
    var selectedType: TypeOfDays?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(saveTapped))
        guard let employee = employee else {
            return
        }
        employeeNameLabel.text = employee.lastName + " " + employee.firstName
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
 
    @objc func saveTapped() {
    }
    
    func showTableAlert(title: String) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250, height: 300)
        daysTypeTable.frame = CGRect(x: 10, y: 0, width: vc.view.frame.width - 35, height: vc.view.frame.height)
        daysTypeTable.layer.cornerRadius = 10
        daysTypeTable.delegate = self
        daysTypeTable.dataSource = self
        daysTypeTable.register(UITableViewCell.self, forCellReuseIdentifier: "dayTypeCell")
        vc.view.addSubview(daysTypeTable)

        let alrController = UIAlertController(title: title,
                                              message: nil,
                                              preferredStyle: .actionSheet)
        alrController.setValue(vc, forKey: "contentViewController")
        alrController.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            self.doneTapped()
        }))
        alrController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alrController, animated: true)
    }
    
    func doneTapped() {
        guard let selectedType = selectedType else {
            UIAlertController.showAlert(message: "Please choose a type of day", from: self)
            return
        }
        
        if workTimeMark == nil {
            workTimeMark = CoreDataManager.shared.newWorkTimeMark()
        }
        workTimeMark?.employee = employee
        workTimeMark?.startDate = selectedDate
        workTimeMark?.endDate = selectedDate
        workTimeMark?.type = selectedType.type
        workTimeMark?.daysType = selectedType
        
        workTimeArray = CoreDataManager.shared.getWorkTime()
        CoreDataManager.shared.save()
        calendarView.reloadData()
    }
}

extension CalendarViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-yyyy"
        let string = formatter.string(from: date)
        selectedDate = date
        showTableAlert(title: string)
        
//        calendar
        print("\(string)")
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        cell.eventIndicator.isHidden = false
        cell.eventIndicator.color = UIColor.green
        
        let workTimeForEmployee = workTimeArray.filter{ $0.employee == employee }
        let dates = Set(workTimeForEmployee.map{ $0.startDate })
        
        if dates.contains(date) {
            cell.eventIndicator.numberOfEvents = 1
        }
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysTypeArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = daysTypeTable.dequeueReusableCell(withIdentifier: "dayTypeCell", for: indexPath)
        let type = daysTypeArray[indexPath.row]
        cell.textLabel?.text = type.typeFullName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedType = daysTypeArray[indexPath.row]
    }
}
