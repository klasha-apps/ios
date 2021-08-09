//
//  RwandaMobileMoney.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 02/09/2020.
//

import Foundation


// MARK: - RwandaMobileMoneyRequest
struct RwandaMobileMoneyRequest: Codable {
    let txRef, amount, currency, network: String?
    let email, phoneNumber, fullname: String?
    let redirecturl: String? = "https://webhook.site/finish"

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case amount, currency, network, email
        case phoneNumber = "phone_number"
        case redirecturl = "redirect_url"
        case fullname
    }
}


// MARK: - RwandaMobileMoneyResponse
struct RwandaMobileMoneyResponse: Codable,FlutterChargeResponse {
    let status, message: String?
    let meta: Meta?
}
