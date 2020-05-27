//
//  UITextField.swift
//  TimeTracking
//
//  Created by Tatsiana on 24.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setRedPlaceholder() {
        let placeholder = self.placeholder ?? ""
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
    }
}
