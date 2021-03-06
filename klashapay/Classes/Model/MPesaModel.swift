import Foundation

// MARK: - MpesaRequest
struct MpesaRequest: Codable {
    let txRef, amount, currency, email: String?
    let phoneNumber, fullname: String?

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case amount, currency, email
        case phoneNumber = "phone_number"
        case fullname
    }
}

// MARK: - MpesaResponse
struct MpesaResponse: Codable {
    let status, message: String?
    let data: MpesaData?
}

// MARK: - MpesaData
struct MpesaData: Codable {
    let id: Int?
    let txRef, flwRef, deviceFingerprint: String?
    let amount, chargedAmount, appFee, merchantFee: Double?
    let processorResponse, authModel, currency, ip: String?
    let narration, status, authURL, paymentType: String?
    let fraudStatus, chargeType, createdAt: String?
    let accountID: Int?
    let customer: Customer?

    enum CodingKeys: String, CodingKey {
        case id
        case txRef = "tx_ref"
        case flwRef = "flw_ref"
        case deviceFingerprint = "device_fingerprint"
        case amount
        case chargedAmount = "charged_amount"
        case appFee = "app_fee"
        case merchantFee = "merchant_fee"
        case processorResponse = "processor_response"
        case authModel = "auth_model"
        case currency, ip, narration, status
        case authURL = "auth_url"
        case paymentType = "payment_type"
        case fraudStatus = "fraud_status"
        case chargeType = "charge_type"
        case createdAt = "created_at"
        case accountID = "account_id"
        case customer
    }
}

