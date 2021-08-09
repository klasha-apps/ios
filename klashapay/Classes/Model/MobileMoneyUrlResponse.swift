//
//  MobileMoneyUrlResponse.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 11/09/2020.
//

import Foundation

struct MobileMoneyUrlResponse :Codable{
    let status,message:String?
    let data:MobileMoneyUrlData
}

struct MobileMoneyUrlData:Codable {
    let flwRef:String?
}


