import Foundation

struct KlashaWalletLoginRequest: Codable {
    let username, password: String
}

struct KlashaWalletLoginResponse: Codable {
    let firstName, lastName, email, exception, error: String?
}

struct KlashaWalletMakePaymentRequest: Codable {
    let currency, amount: String
    let rate: Int
    let paymentType, sourceCurrency, sourceAmount: String
    let rememberMe: Bool
    let phoneNumber, fullname, txRef, email: String

    enum CodingKeys: String, CodingKey {
        case currency, amount, rate, paymentType, sourceCurrency, sourceAmount, rememberMe
        case phoneNumber = "phone_number"
        case fullname
        case txRef = "tx_ref"
        case email
    }
}

// MARK: - KlashaWalletMakePaymentResponse
public struct KlashaWalletMakePaymentResponse: Codable {
    let id: Int?
    let toWallet: Wallet?
    let walletTnxID: String?
    let amount: Int?
    let narration: String?
    let fromWallet: Wallet?
    let tempID: String?
    let tnxStatus: String?
    let dAmount: Int?
    let createdAt, updatedAt, error: String?

    enum CodingKeys: String, CodingKey {
        case id, toWallet
        case walletTnxID = "walletTnxId"
        case amount, narration, fromWallet
        case tempID = "tempId"
        case tnxStatus, dAmount, createdAt, updatedAt, error
    }
}

// MARK: - Wallet
struct Wallet: Codable {
    let id: Int?
    let accountNo: String?
    let balance: Double?
    let userID: Int?
    let businessID: Int?
    let currency: String?
    let verified: Bool?
    let secondStepVerified, enabled: Bool?
    let coin: String?
    let tag, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, accountNo, balance
        case userID = "userId"
        case businessID = "businessId"
        case currency, verified, secondStepVerified, enabled, coin, tag, createdAt, updatedAt
    }
}


