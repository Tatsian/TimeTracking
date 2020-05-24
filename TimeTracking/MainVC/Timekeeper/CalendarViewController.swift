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
    @IBOutlet weak var calendar: FSCalendar!
    
    var employeeName: String?
    var daysTypeArray = CoreDataManager.shared.getTypeOfDays()
    var daysTypeTable = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(cancelTapped))
        
        employeeNameLabel.text = employeeName
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
//    func showPickerAlert(title: String) {
//        let vc = UIViewController()
//        vc.preferredContentSize = CGSize(width: 250,height: 300)
//        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        vc.view.addSubview(pickerView)
//        let editRadiusAlert = UIAlertController(title: "Choose day type",
//                                                message: title,
//                                                preferredStyle: .alert)
//        editRadiusAlert.setValue(vc, forKey: "contentViewController")
//        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
//        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        self.present(editRadiusAlert, animated: true)
//    }
    
    func showTableAlert(title: String) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250, height: 300)
        daysTypeTable.frame = CGRect(x: 10, y: 0, width: vc.view.frame.width - 35, height: vc.view.frame.height)
        daysTypeTable.layer.cornerRadius = 10
        daysTypeTable.delegate = self
        daysTypeTable.dataSource = self
        daysTypeTable.register(UITableViewCell.self, forCellReuseIdentifier: "dayTypeCell")
        daysTypeTable.backgroundColor = UIColor.green
        vc.view.addSubview(daysTypeTable)

        let alrController = UIAlertController(title: title,
                                              message: nil,
                                              preferredStyle: .actionSheet)
        alrController.setValue(vc, forKey: "contentViewController")
        alrController.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        alrController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alrController, animated: true)
    }

    static func storyboardInstance() -> PopOverTimeStampViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "PopupVC")
            as? PopOverTimeStampViewController
    }
}

extension CalendarViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-yyyy"
        let string = formatter.string(from: date)
//        showPickerAlert(title: string)
        showTableAlert(title: string)
//        guard let testVC = CalendarViewController.storyboardInstance() else { return }
//        let navigationController = UINavigationController(rootViewController: testVC)
//        navigationController.modalPresentationStyle = .popover
//        self.present(navigationController, animated: true, completion: nil)
        
        print("\(string)")
    }
}

//extension CalendarViewController: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        let days = CoreDataManager.shared.getTypeOfDays()
//        return days.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        let days = CoreDataManager.shared.getTypeOfDays()[row]
//        return days.typeFullName
//    }
//
//}
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysTypeArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = daysTypeTable.dequeueReusableCell(withIdentifier: "dayTypeCell", for: indexPath)
        let type = daysTypeArray[indexPath.row]
        cell.textLabel?.text = type.type
        return cell
    }
}
