//
//  NigeriaBankModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 02/09/2020.
//

import Foundation

// MARK: - NigeriaBankTransferRequest
struct NigeriaBankTransferRequest: Codable {
    let txRef, amount, accountBank, accountNumber: String?
    let currency, email, phoneNumber, passCode, bvn, fullname: String?

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case amount
        case accountBank = "account_bank"
        case accountNumber = "account_number"
        case currency, email
        case phoneNumber = "phone_number"
        case fullname
        case passCode = "passcode"
        case bvn 
    }
}

// MARK: - NigeriaBankTransferResponse
struct NigeriaBankTransferResponse: Codable {
    let status, message: String?
    let data: NigeriaBankTransferData?
    
}

// MARK: - NigeriaBankTransferData
struct NigeriaBankTransferData: Codable,FlutterChargeResponse {
    let id: Int?
    let txRef, flwRef, deviceFingerprint: String?
    let amount, chargedAmount: Int?
    let appFee: Double?
    let merchantFee: Int?
    let authModel, currency, ip, narration: String?
    let status, authURL, paymentType, fraudStatus: String?
    let createdAt: String?
    let accountID: Int?
    let customer: Customer?
    let account: Account?
    let meta: Meta?
    

    enum CodingKeys: String, CodingKey {
        case id
        case txRef = "tx_ref"
        case flwRef = "flw_ref"
        case deviceFingerprint = "device_fingerprint"
        case amount
        case chargedAmount = "charged_amount"
        case appFee = "app_fee"
        case merchantFee = "merchant_fee"
        case authModel = "auth_model"
        case currency, ip, narration, status
        case authURL = "auth_url"
        case paymentType = "payment_type"
        case fraudStatus = "fraud_status"
        case createdAt = "created_at"
        case accountID = "account_id"
        case customer, account, meta
    }
}
