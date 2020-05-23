//
//  VC.swift
//  TimeTracking
//
//  Created by Tatsiana on 24.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setRedPlaceholder(for field: UITextField) {
        let placeholder = field.placeholder ?? ""
        field.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
    }
}
