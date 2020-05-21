//
//  ViewController.swift
//  TimeTracking
//
//  Created by Tatsiana on 19.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func administratorButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func hrButtonTapped(_ sender: UIButton) {
        EmployeesViewController.isHRManager = true
    }
    
    @IBAction func timekeeperButtonTapped(_ sender: UIButton) {
        EmployeesViewController.isHRManager = false
    }
}

//        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "DepartmentVC") as UIViewController
//        self.navigationController?.pushViewController(vc, animated: true)
//        self.present(vc, animated: true, completion: nil)
    
