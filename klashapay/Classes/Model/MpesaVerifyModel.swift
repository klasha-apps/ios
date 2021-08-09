//
//  MpesaVerifyModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 26/08/2020.
//

import Foundation

// MARK: - MpesaVerifyRequest
struct MpesaVerifyRequest: Codable {
    let flwRef: String?

    enum CodingKeys: String, CodingKey {
        case flwRef = "flw_ref"
    }
}

// MARK: - MpesaVerifyRequest
struct MpesaVerifyResponse: Codable {
    let status, message: String?
    let data: MpesaVerifyData?
}

// MARK: - MpesaVerifyData
struct MpesaVerifyData: Codable {
    let txRef, flwRef: String?
    let amount, chargedAmount: Double?
    let appFee: Double?
    let merchantFee: Double?
    let currency, ip, narration, status: String?
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
        case currency, ip, narration, status, meta
        case processorResponse = "processor_response"
        case customer
    }
}

extension MpesaVerifyData{
    func toFlutterResponse() -> FlutterwaveDataResponse{
        return FlutterwaveDataResponse(txRef: txRef, flwRef: flwRef, deviceFingerprint: nil, amount: amount, chargedAmount: chargedAmount, appFee: appFee, merchantFee: merchantFee, processorResponse: processorResponse, authModel: nil, currency: currency, ip: ip, narration: narration, status: status, authURL:nil, paymentType: nil, fraudStatus: nil, chargeType: nil, createdAt: nil, plan: nil, id: nil, accountID: nil, customer: customer, card: nil)
    }
}


