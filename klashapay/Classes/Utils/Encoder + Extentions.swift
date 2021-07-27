//
//  Encoder + Extentions.swift
//  Alamofire
//
//  Created by Rotimi Joshua on 30/08/2020.
//

import Foundation


extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}
