//
//  SaveCardModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 13/09/2020.
//

import Foundation

// MARK: - FetchSavedCardRequest
struct FetchSavedCardRequest: Codable {
    let deviceKey, publicKey: String?

    enum CodingKeys: String, CodingKey {
        case deviceKey = "device_key"
        case publicKey = "public_key"
    }
}

// MARK: - FetchSavedCardResponse
struct FetchSavedCardResponse: Codable {
    let status, message: String?
    let data: [SavedCard]?
}

// MARK: - CardDatas
struct CardDatas: Codable {
    let device, mobileNumber, email, cardHash: String?
    let card: CardNew?

    enum CodingKeys: String, CodingKey {
        case device
        case mobileNumber = "mobile_number"
        case email
        case cardHash = "card_hash"
        case card
    }
}

// MARK: - CardNew
struct CardNew: Codable {
    let maskedPan, cardBrand: String?

    enum CodingKeys: String, CodingKey {
        case maskedPan = "masked_pan"
        case cardBrand = "card_brand"
    }
}




