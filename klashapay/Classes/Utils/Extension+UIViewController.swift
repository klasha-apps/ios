//
//  Extension+UIViewController.swift
//  klashapay
//
//  Created by Adegoke Ayomikun on 02/07/2021.
//

import Foundation
extension UIViewController {
    public static func loadFromNib(bundle: Bundle) -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: bundle)
        }

        return instantiateFromNib()
    }
}
