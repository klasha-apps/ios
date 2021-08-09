//
//  RemoveCardModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 15/09/2020.
//

import Foundation

// MARK: - RemoveCardRequest
struct RemoveCardRequest: Codable {
    let mobileNumber, publicKey, cardHash: String?

    enum CodingKeys: String, CodingKey {
        case mobileNumber = "mobile_number"
        case publicKey = "public_key"
        case cardHash = "card_hash"
    }
}

// MARK: - RemoveCardResponse
struct RemoveCardResponse: Codable {
    let status, message, data: String?
}
