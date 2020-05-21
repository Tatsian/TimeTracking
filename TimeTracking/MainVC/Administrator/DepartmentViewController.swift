//
//  DepartmentViewController.swift
//  TimeTracking
//
//  Created by Tatsiana on 19.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit
import CoreData

class DepartmentViewController: UIViewController {

    @IBOutlet weak var departmentTable: UITableView!
    
    var departmentArray = [Departments]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        departmentArray = CoreDataManager.shared.getDepartmentsList()
        departmentTable.reloadData()
    }
    
    static func storyboardInstance() -> AddDepartmentViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "AddDepartmentVC")
            as? AddDepartmentViewController
    }
}

extension DepartmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = departmentTable.dequeueReusableCell(withIdentifier: "DepartmentCell", for: indexPath)
        let department = departmentArray[indexPath.row]
        cell.textLabel?.text = department.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let testVC = DepartmentViewController.storyboardInstance() else { return }
        testVC.department = departmentArray[indexPath.row]
        let navigationController = UINavigationController(rootViewController: testVC)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if departmentArray.count > indexPath.row {
            let department = departmentArray[indexPath.row]
            departmentArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataManager.shared.delete(department: department)
        }
    }
}
