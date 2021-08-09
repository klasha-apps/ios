//
//  USSDModel.swift
//  Alamofire
//
//  Created by Rotimi Joshua on 02/09/2020.
//

import Foundation

// MARK: - USSDRequest
struct USSDRequest: Codable {
    let txRef, accountBank, amount, currency: String?
    let email, phoneNumber, fullname: String?

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case accountBank = "account_bank"
        case amount, currency, email
        case phoneNumber = "phone_number"
        case fullname
    }
}


// MARK: - USSDResponse
struct USSDResponse: Codable {
    let status, message: String?
    let data: USSDData?
    let meta: Meta?
    
}

// MARK: - USSDData
struct USSDData: Codable {
    let id: Int?
    let txRef, flwRef, deviceFingerprint: String?
    let amount, chargedAmount: Int?
    let appFee: Double?
    let merchantFee: Int?
    let processorResponse, authModel, currency, ip: String?
    let narration, status, paymentType, fraudStatus: String?
    let chargeType, createdAt: String?
    let accountID: Int?
    let customer: Customer?
    let paymentCode: String?

    enum CodingKeys: String, CodingKey {
        case id
        case txRef = "tx_ref"
        case flwRef = "flw_ref"
        case deviceFingerprint = "device_fingerprint"
        case amount
        case chargedAmount = "charged_amount"
        case appFee = "app_fee"
        case merchantFee = "merchant_fee"
        case processorResponse = "processor_response"
        case authModel = "auth_model"
        case currency, ip, narration, status
        case paymentType = "payment_type"
        case fraudStatus = "fraud_status"
        case chargeType = "charge_type"
        case createdAt = "created_at"
        case accountID = "account_id"
        case customer
        case paymentCode = "payment_code"
    }
}
