//
//  UgandaMobileMoneyModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 02/09/2020.
//

import Foundation

// MARK: - UgandaMobileMoneyRequest
struct UgandaMobileMoneyRequest: Codable {
    let txRef, amount, email, phoneNumber: String?
    let currency: String?
    let redirectURL: String? = "https://webhook.site/finish"
    let network: String?

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case amount, email
        case phoneNumber = "phone_number"
        case currency
        case redirectURL = "redirect_url"
        case network
    }
}


// MARK: - UgandaMobileMoneyResponse
struct UgandaMobileMoneyResponse: Codable, FlutterChargeResponse  {
    let status, message: String?
    let meta: Meta?
}
