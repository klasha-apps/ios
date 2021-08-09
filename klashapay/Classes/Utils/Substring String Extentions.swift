//
//  Substring String Extentions.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 17/09/2020.
//

import Foundation


public extension String {

    //right is the first encountered string after left
    func between(_ left: String, _ right: String) -> String? {
        guard
            let leftRange = range(of: left), let rightRange = range(of: right, options: .backwards)
            , leftRange.upperBound <= rightRange.lowerBound
            else { return nil }

        let sub = self[leftRange.upperBound...]
        let closestToLeftRange = sub.range(of: right)!
        return String(sub[..<closestToLeftRange.lowerBound])
    }

    var length: Int {
        get {
            return self.count
        }
    }

    func substring(to : Int) -> String {
        let toIndex = self.index(self.startIndex, offsetBy: to)
        return String(self[...toIndex])
    }

    func substring(from : Int) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: from)
        return String(self[fromIndex...])
    }

    func substring(_ r: Range<Int>) -> String {
        let fromIndex = self.index(self.startIndex, offsetBy: r.lowerBound)
        let toIndex = self.index(self.startIndex, offsetBy: r.upperBound)
        let indexRange = Range<String.Index>(uncheckedBounds: (lower: fromIndex, upper: toIndex))
        return String(self[indexRange])
    }

    func character(_ at: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: at)]
    }

    func lastIndexOfCharacter(_ c: Character) -> Int? {
        guard let index = range(of: String(c), options: .backwards)?.lowerBound else
        { return nil }
        return distance(from: startIndex, to: index)
    }
    
    func substring(with r: Range<Int>) -> String {
            let startIndex = index(from: r.lowerBound)
            let endIndex = index(from: r.upperBound)
            return substring(with: startIndex..<endIndex)
        }
    
    func index(from: Int) -> Index {
            return self.index(startIndex, offsetBy: from)
        }
}
