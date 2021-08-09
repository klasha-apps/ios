//
//  PwbtVerify.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 26/08/2020.
//

import Foundation

// MARK: - PwbtVerifyRequest
struct PwbtVerifyRequest: Codable {
    let txRef: String?

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
    }
}

// MARK: - PwbtVerifyResponse
struct PwbtVerifyResponse: Codable {
    let status, message: String?
    let data: PwbtVerifyData?
}

// MARK: - PwbtVerifyData
struct PwbtVerifyData: Codable {
    let txRef, flwRef: String?
    let amount: Double?
    let chargedAmount, appFee: Double?
    let merchantFee: Double?
    let authModel, currency, ip, narration: String?
    let status, paymentType: String?
    let meta: Meta?
    let processorResponse: String?
    let customer: Customer?

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case flwRef = "flw_ref"
        case amount
        case chargedAmount = "charged_amount"
        case appFee = "app_fee"
        case merchantFee = "merchant_fee"
        case authModel = "auth_model"
        case currency, ip, narration, status
        case paymentType = "payment_type"
        case meta
        case processorResponse = "processor_response"
        case customer
    }
}

extension PwbtVerifyData {
    func toFlutterResponse() -> FlutterwaveDataResponse{
        return FlutterwaveDataResponse(txRef: txRef, flwRef: flwRef, deviceFingerprint: nil, amount: amount, chargedAmount: chargedAmount, appFee: appFee, merchantFee: merchantFee, processorResponse: processorResponse, authModel: authModel, currency: currency, ip: ip, narration: narration, status: status, authURL: nil, paymentType: paymentType, fraudStatus: nil, chargeType: nil, createdAt: nil, plan: nil, id: nil, accountID: nil, customer: customer, card: nil)
    }
}



