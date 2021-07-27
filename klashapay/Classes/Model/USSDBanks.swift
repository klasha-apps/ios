//
//  USSDBanks.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 07/09/2020.
//

import Foundation


struct USSDBanks {
    let bankName:String
    let bankCode:String
    let bankUssdCode:String
}


func getUssdBanks() -> [USSDBanks]{
    [
        USSDBanks(bankName: "Fidelity Bank", bankCode: "070", bankUssdCode: "770"),
        USSDBanks(bankName: "Guaranty Trust Bank", bankCode: "058", bankUssdCode: "737"),
        USSDBanks(bankName: "Keystone Bank", bankCode: "082", bankUssdCode: "7111"),
        USSDBanks(bankName: "Sterling Bank", bankCode: "232", bankUssdCode: "822"),
        USSDBanks(bankName: "United Bank for Africa", bankCode: "305", bankUssdCode: "919"),
        USSDBanks(bankName: "Unity Bank",  bankCode: "215", bankUssdCode: "7799"),
        USSDBanks(bankName: "Zenith Bank", bankCode: "057", bankUssdCode: "966"),
    ]
}
