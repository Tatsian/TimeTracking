//
//  TimeStampViewController.swift
//  TimeTracking
//
//  Created by Tatsiana on 22.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import FSCalendar

class TimeStampViewController: UIViewController {

    @IBOutlet weak var employeeNameLabel: UILabel!
    @IBOutlet weak var calendar: FSCalendar!
    
    var employeeName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                           target: self,
                                                           action: #selector(cancelTapped))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(cancelTapped))
        
        employeeNameLabel.text = employeeName
        // Do any additional setup after loading the view.
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func showPickerAlert(title: String) {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
        pickerView.delegate = self
        pickerView.dataSource = self
        vc.view.addSubview(pickerView)
        let editRadiusAlert = UIAlertController(title: "Choose day type",
                                                message: title,
                                                preferredStyle: .alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(editRadiusAlert, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TimeStampViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-yyyy"
        let string = formatter.string(from: date)
        showPickerAlert(title: string)
        print("\(string)")
    }
}

extension TimeStampViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let days = CoreDataManager.shared.getTypeOfDays()
        return days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let days = CoreDataManager.shared.getTypeOfDays()[row]
        return days.typeFullName
    }
    
}
