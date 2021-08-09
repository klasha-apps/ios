//
//  Extension+MDCOutlined.swift
//  FlutterwaveSDK
//
//  Created by Rotimi Joshua on 30/09/2020.
//  Copyright © 2020 Flutterwave. All rights reserved.
//

import Foundation
import UIKit


extension String {
    
    func hasPrefix(_ prefixes: [String]) -> Bool {
        for prefix in prefixes {
            if hasPrefix(prefix) {
                return true
            }
        }
        return false
    }
    
    func insert(_ string: String, index: Int) -> String {
        return String(prefix(index)) + string + String(suffix(count - index))
    }
    
    func stripSlash() -> String {
        return self.replacingOccurrences(of: "/", with: "")
    }
    func stripSpace() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    func stripDash() -> String {
        return self.replacingOccurrences(of: "-", with: "")
    }
}

extension StringProtocol where Self: RangeReplaceableCollection {
    var removingAllWhitespaces: Self {
        filter { !$0.isWhitespace }
    }
    mutating func removeAllWhitespaces() {
        removeAll(where: \.isWhitespace)
    }
}
