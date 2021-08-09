//
//  EmptyString+Extension.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 11/09/2020.
//


import Foundation
import UIKit

extension Optional {
    public func or(other: Wrapped) -> Wrapped {
        if let ret = self {
            return ret
        } else {
            return other
        }
    }
}
extension Optional where Wrapped == String {
    public func orEmpty() -> String {
        return self.or(other: "")
    }
}
