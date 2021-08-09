//
//  SendCardOTPModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 15/09/2020.
//

import Foundation

// MARK: - SendCardOTPRequest
struct SendCardOTPRequest: Codable {
    let cardHash, deviceKey, publicKey: String?

    enum CodingKeys: String, CodingKey {
        case cardHash = "card_hash"
        case deviceKey = "device_key"
        case publicKey = "public_key"
    }
}

// MARK: - SendCardOTPResponse
struct SendCardOTPResponse: Codable {
    let status, message, data: String?
}
