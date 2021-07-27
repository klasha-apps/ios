//
//  TrackAPIModel.swift
//  FlutterwaveSDK
//
//  Created by Rotimi Joshua on 15/11/2020.
//

import Foundation


// MARK: - TrackAPIModel
struct TrackAPIModelRequest: Codable {
    let publicKey, language, version, title, message: String?
   
}

// MARK: - TrackAPIModelResponse
struct TrackAPIModelResponse: Codable {
    let status,statusdec: String?
}


enum FeaturesTrackerName:String {
    
    case initCardCharge = "Initiate-Card-charge"
    case initCardChargeError = "Initiate-Card-charge-error"
    case validateCard = "Validate-Card-charge"
    case validateCardError = "Validate-Card-charge-error"
    case verifyCard = "Verify-Card-charge"
    case verifyCardError = "Verify-Card-charge-error"
    case initateAccountCharge = "Initiate-Account-charge"
    case initateAccountChargeError = "Initiate-Account-charge-error"
    case accountChargeValidate = "Account-charge-validate"
    case accountChargeValidateError = "Account-charge-validate-error"
    case accountVerify = "Account-charge-verify"
    case accountVerifyError = "Account-charge-verify-error"
    case ussd = "USSD"
    case ussdError = "USSD-error"
    case bankTransfer = "Bank-Transfer"
    case bankTransferError = "Bank-Transfer-Error"
    case directDebit = "Direct-Debit"
    case directDebitError = "Direct-Debit-Error"
    case ukAccountTransfer = "UK-Account-Transfer"
    case ukAccountTransferError = "UK-Account-Transfer-Error"
    case ghanaMoney = "Ghana-Money"
    case ghanaMoneyError = "Ghana-Money-Error"
    case rwandaMoney = "Rwanda-Money"
    case rwandaMoneyError = "Rwanda-Money-Error"
    case ugandaMoney = "Uganda-Money"
    case ugandaMoneyError = "Uganda-Money-Error"
    case zambiaMoney = "Zambia-Money"
    case zambiaMoneyError = "Zambia-Money-Error"
    case mpesaMoney = "Mpesa-Money"
    case mpesaMoneyError = "Mpesa-Money-Error"
    case francoPhoneMoney = "Fracophone-Money"
    case francoPhoneMoneyError = "Fracophone-Money-Error"
    case voucherMoney = "Voucher-Money"
    case voucherMoneyError = "Voucher-Money-Error"
    case saveCard = "Save-Card"
    case saveCardError = "Save-Card-Error"
    case fetchCard = "Fetch-Card"
    case fetchCardError = "Fetch-Card-Error"
    case removeCard = "Remove-Card"
    case removeCardError = "Remove-Card-Error"
    case sendSavedCardOTP = "Send-Saved-Card-OTP"
    case sendSavedCardOTPError = "Send-Saved-Card-OTP-Error"
    case chargeSavedCard = "Charge-Saved-Card"
    case chargeSavedCardError = "Charge-Saved-Card-Error"
   
    
}
