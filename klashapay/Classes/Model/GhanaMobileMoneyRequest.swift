import Foundation

// MARK: - GhanaMobileMoneyRequest
struct GhanaMobileMoneyRequest: Codable {
    let txRef, amount, currency, voucher: String?
    let network, email, phoneNumber, fullname: String?
    let redirecturl: String? = "https://webhook.site/finish"

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case amount, currency, voucher, network, email
        case phoneNumber = "phone_number"
        case redirecturl = "redirect_url"
        case fullname
    }
}

// MARK: - GhanaMobileMoneyResponse
struct GhanaMobileMoneyResponse: Codable {
    let status, message: String?
    let data: GHMomoData?
    let meta: GHMomoMeta?
    let txRef: String?

    enum CodingKeys: String, CodingKey {
        case status, message, data, meta
        case txRef = "tx_ref"
    }
}

// MARK: - DataClass
struct GHMomoData: Codable {
    let id: Double?
    let txRef, flwRef, deviceFingerprint: String?
    let amount, chargedAmount, appFee, merchantFee: Double?
    let processorResponse, authModel, currency, ip: String?
    let narration, status, paymentType, fraudStatus: String?
    let chargeType, createdAt: String?
    let accountID: Double?
    let customer: GHMomoCustomer?

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
        case paymentType = "payment_type"
        case fraudStatus = "fraud_status"
        case chargeType = "charge_type"
        case createdAt = "created_at"
        case accountID = "account_id"
        case customer
    }
}

// MARK: - Customer
struct GHMomoCustomer: Codable {
    let id: Double?
    let phoneNumber, name, email, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case phoneNumber = "phone_number"
        case name, email
        case createdAt = "created_at"
    }
}

// MARK: - Meta
struct GHMomoMeta: Codable {
    let authorization: GHMomoAuthorization?
}

// MARK: - Authorization
struct GHMomoAuthorization: Codable {
    let instruction: String?
}
