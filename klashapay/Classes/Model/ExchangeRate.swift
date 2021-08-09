//
//  ExchangeRate.swift
//  klashapay
//
//  Created by Adegoke Ayomikun on 14/07/2021.
//

import Foundation

// MARK: - GetExchangeRateRequest
struct GetExchangeRateRequest: Codable {
    let sourceCurrency: String?
    let amount: String?
    let email, phone, destinationCurrency: String?
}

// MARK: - GetExchangeRateResponse
struct GetExchangeRateResponse: Codable {
    let amount: Int?
    let rate: Double?
    let destinationCurrency: String?
}

