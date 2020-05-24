//
//  PopOverTimeStampViewController.swift
//  TimeTracking
//
//  Created by Tatsiana on 24.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

class PopOverTimeStampViewController: UIViewController {

    @IBOutlet weak var daysTypeTable: UITableView!
    @IBOutlet weak var popupView: UIView!
    
    var daysTypeArray = CoreDataManager.shared.getTypeOfDays()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func okButton(_ sender: UIButton) {
    }
}

extension PopOverTimeStampViewController: UITableViewDelegate, UITableViewDataSource {
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
