//
//  VoucherChargeModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 02/09/2020.
//

import Foundation

// MARK: - VoucherChargeRequest
struct VoucherChargeRequest: Codable {
    let txRef, amount, currency, pin: String?
    let email, phoneNumber, fullname: String?

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case amount, currency, pin, email
        case phoneNumber = "phone_number"
        case fullname
    }
}


// MARK: - VoucherChargeResponse
struct VoucherChargeResponse: Codable {
    let status, message: String?
    let data: VoucherChargeData?
}

// MARK: - VoucherChargeData
struct VoucherChargeData: Codable {
    let id: Int?
    let txRef, flwRef, deviceFingerprint: String?
    let amount, chargedAmount: Int?
    let appFee: Double?
    let merchantFee: Int?
    let processorResponse, authModel, currency, ip: String?
    let narration, status, authURL, paymentType: String?
    let fraudStatus, chargeType, createdAt: String?
    let accountID: Int?
    let customer: Customer?

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
        case authURL = "auth_url"
        case paymentType = "payment_type"
        case fraudStatus = "fraud_status"
        case chargeType = "charge_type"
        case createdAt = "created_at"
        case accountID = "account_id"
        case customer
    }
}
