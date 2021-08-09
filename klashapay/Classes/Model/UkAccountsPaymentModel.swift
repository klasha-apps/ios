//
//  UkAccountsPaymentModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 02/09/2020.
//

import Foundation

// MARK: - UKAccountPaymentsRequest
struct UKAccountPaymentsRequest: Codable {
    let txRef, amount, accountBank, accountNumber: String?
    let currency, email, phoneNumber, fullname: String?

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case amount
        case accountBank = "account_bank"
        case accountNumber = "account_number"
        case currency, email
        case phoneNumber = "phone_number"
        case fullname
    }
}


// MARK: - UKAccountPaymentsResponse
struct UKAccountPaymentsResponse: Codable {
    let status, message: String?
    let data: UkAccountPaymentData?
}

// MARK: - UkAccountPaymentData
struct UkAccountPaymentData: Codable {
    let amount, type: String?
    let redirect: Bool?
    let createdAt, orderRef, flwRef: String?
    let redirectURL: String?
    let paymentCode, typeData: String?
    let meta: Meta?

    enum CodingKeys: String, CodingKey {
        case amount, type, redirect
        case createdAt = "created_at"
        case orderRef = "order_ref"
        case flwRef = "flw_ref"
        case redirectURL = "redirect_url"
        case paymentCode = "payment_code"
        case typeData = "type_data"
        case meta
    }
}

