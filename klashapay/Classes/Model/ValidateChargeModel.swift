//
//  ValidateChargeModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 26/08/2020.
//

import Foundation

// MARK: - ValidateChargeRequest
struct ValidateChargeRequest:Codable {
    let otp, flwRef, type: String?
    enum CodingKeys: String, CodingKey {
        case otp
        case flwRef = "flw_ref"
        case type = "type"
    }
}




// MARK: - ValidateChargeResponse
struct ValidateChargeResponse:Codable {
    let status, message: String?
    let data: ValidChargeData?
}

// MARK: - DataClass
struct ValidChargeData:Codable {
    let id: Int?
    let txRef, flwRef, deviceFingerprint: String?
    let amount, chargedAmount, appFee, merchantFee: Double?
    let processorResponse, authModel, currency, ip: String?
    let narration, status, authURL, paymentType: String?
    let plan: String?
    let fraudStatus, chargeType, createdAt: String?
    let accountID: Int?
    let customer: Customer?
    let card: CardData?
    
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
        case plan
        case fraudStatus = "fraud_status"
        case chargeType = "charge_type"
        case createdAt = "created_at"
        case accountID = "account_id"
        case customer, card
    }
}


extension ValidChargeData {
    func toFlutterResponse() -> FlutterwaveDataResponse{
        return FlutterwaveDataResponse(txRef: txRef, flwRef: flwRef, deviceFingerprint: deviceFingerprint, amount: amount, chargedAmount: chargedAmount, appFee: appFee, merchantFee: merchantFee, processorResponse: processorResponse, authModel: authModel, currency: currency, ip: ip, narration: narration, status: status, authURL: authURL, paymentType: paymentType, fraudStatus: fraudStatus, chargeType: chargeType, createdAt: createdAt, plan: plan, id: id, accountID: accountID, customer: customer, card: card)
    }
}
