//
//  SaveCardInitate.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 13/09/2020.
//

import Foundation


// MARK: - SaveCardNewRequest
struct SaveCardNewRequest: Codable {
    let processorReference, publicKey, deviceEmail, device: String?
    let deviceKey: String?

    enum CodingKeys: String, CodingKey {
        case processorReference = "processor_reference"
        case publicKey = "public_key"
        case deviceEmail = "device_email"
        case device
        case deviceKey = "device_key"
    }
}


// MARK: - SaveCardNewResponse
struct SaveCardNewResponse: Codable {
    let status, message, data: String?
}
