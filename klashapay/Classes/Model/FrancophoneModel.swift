//
//  FrancophoneModel.swift
//  RaveSDK
//
//  Created by Rotimi Joshua on 02/09/2020.
//

import Foundation

// MARK: - FrancophoneMobileMoneyRequest
struct FrancophoneMobileMoneyRequest: Codable {
    let txRef, amount, currency, email: String?
    let phoneNumber, country, fullname: String?
    let redirectURL: String? = "https://webhook.site/finish"
    
    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case amount, currency, email
        case phoneNumber = "phone_number"
        case redirectURL = "redirect_url"
        case fullname
        case country
    }
}

// MARK: - FrancophoneMobileMoneyResponse
struct FrancophoneMobileMoneyResponse: Codable, FlutterChargeResponse {
    let status, message: String?
    let data: FrancoPhoneMobileData?
    let meta: Meta?
}

// MARK: - FrancoPhoneMobileData
struct FrancoPhoneMobileData: Codable {
    let id: Int?
    let txRef, flwRef, orderID, deviceFingerprint: String?
    let amount, chargedAmount, appFee, merchantFee: Double?
    let authModel, currency, ip, narration: String?
    let status, paymentType, fraudStatus, chargeType: String?
    let createdAt: String?
    let accountID: Int?
    let customer: Customer?
    let processorResponse: String?

    enum CodingKeys: String, CodingKey {
        case id
        case txRef = "tx_ref"
        case flwRef = "flw_ref"
        case orderID = "order_id"
        case deviceFingerprint = "device_fingerprint"
        case amount
        case chargedAmount = "charged_amount"
        case appFee = "app_fee"
        case merchantFee = "merchant_fee"
        case authModel = "auth_model"
        case currency, ip, narration, status
        case paymentType = "payment_type"
        case fraudStatus = "fraud_status"
        case chargeType = "charge_type"
        case createdAt = "created_at"
        case accountID = "account_id"
        case customer
        case processorResponse = "processor_response"
    }
}



struct FrancophoneCountries {
    let countryName:String
    let countryCode:String
    
}


func getFrancophoneCountries(countryCode: String) -> [FrancophoneCountries]{
    if countryCode == "XAF" {
        return  [
               FrancophoneCountries(countryName: "Cameroon", countryCode: "CM")

           ]
    }else if countryCode == "XOF"{
        return  [
               FrancophoneCountries(countryName: "Burkina Faso", countryCode: "BF"),
               FrancophoneCountries(countryName: "Cote d'Ivoire", countryCode: "CI"),
               FrancophoneCountries(countryName: "Guinea", countryCode: "GN"),
               FrancophoneCountries(countryName: "Senegal", countryCode: "SN")
           ]
    }else{
        return []
    }

}


//func getFrancophoneCountries(countryCode: String) -> [FrancophoneCountries]{
//        return  [
//               FrancophoneCountries(countryName: "Burkina Faso", countryCode: "BF"),
//               FrancophoneCountries(countryName: "Cote d'Ivoire", countryCode: "CL"),
//               FrancophoneCountries(countryName: "Guinea", countryCode: "GN"),
//               FrancophoneCountries(countryName: "Senegal", countryCode: "SN"),
//               FrancophoneCountries(countryName: "Cameroon", countryCode: "CM")
//           ]
//    }
//

