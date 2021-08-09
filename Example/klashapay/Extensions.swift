//
//  Extensions.swift
//  klashapay_Example
//
//  Created by Adegoke Ayomikun on 04/08/2021.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

extension UITextField {

    func underlined(){
            let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = UIColor(hex: "#e75241").cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
            border.borderWidth = width
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }

}


extension UITextField {
    var isEmpty: Bool {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
}
