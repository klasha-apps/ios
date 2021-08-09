//
//  ChargeSavedCardModel.swift
//  FlutterwaveSDK
//
//  Created by Rotimi Joshua on 30/11/2020.
//

import Foundation


// MARK: - ChargeSavedCardRequest
struct ChargeSavedCardRequest: Codable {
    let publicKey, client, alg : String?
    enum CodingKeys: String, CodingKey {
        case publicKey = "PBFPubKey"
        case client
        case alg
    }
}


// MARK: - ChargeSavedCard
struct ChargeSavedCardResponse: Codable {
    let status, message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let id: Int?
    let txRef, orderRef, flwRef: String?
    let redirectURL: String?
    let deviceFingerprint: String?
    let settlementToken: JSONNull?
    let cycle: String?
    let amount, chargedAmount: Int?
    let appfee: Double?
    let merchantfee, merchantbearsfee: Int?
    let chargeResponseCode: String?
    let raveRef: JSONNull?
    let chargeResponseMessage, authModelUsed, currency, ip: String?
    let narration, status, modalauditid, vbvrespmessage: String?
    let authurl: String?
    let vbvrespcode: String?
    let acctvalrespmsg, acctvalrespcode: JSONNull?
    let paymentType: String?
    let paymentPlan, paymentPage: JSONNull?
    let paymentID, fraudStatus, chargeType: String?
    let isLive: Int?
    let retryAttempt, getpaidBatchID: JSONNull?
    let createdAt, updatedAt: String?
    let deletedAt: JSONNull?
    let customerID, accountID: Int?

    enum CodingKeys: String, CodingKey {
        case id, txRef, orderRef, flwRef
        case redirectURL = "redirectUrl"
        case deviceFingerprint = "device_fingerprint"
        case settlementToken = "settlement_token"
        case cycle, amount
        case chargedAmount = "charged_amount"
        case appfee, merchantfee, merchantbearsfee, chargeResponseCode, raveRef, chargeResponseMessage, authModelUsed, currency
        case ip = "IP"
        case narration, status, modalauditid, vbvrespmessage, authurl, vbvrespcode, acctvalrespmsg, acctvalrespcode, paymentType, paymentPlan, paymentPage
        case paymentID = "paymentId"
        case fraudStatus = "fraud_status"
        case chargeType = "charge_type"
        case isLive = "is_live"
        case retryAttempt = "retry_attempt"
        case getpaidBatchID = "getpaidBatchId"
        case createdAt, updatedAt, deletedAt
        case customerID = "customerId"
        case accountID = "AccountId"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
