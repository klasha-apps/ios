import Foundation

// MARK: - BankTransferRequest
struct BankTransferRequest: Codable {
    let txRef, phoneNumber, amount, currency: String?
    let email: String?

    enum CodingKeys: String, CodingKey {
        case txRef = "tx_ref"
        case phoneNumber = "phone_number"
        case amount, currency, email
    }
}


// MARK: - BankTransferResponse
struct BankTransferResponse: Codable {
    let status, message: String?
    let meta: BankTransferMeta?
    let txRef: String?

    enum CodingKeys: String, CodingKey {
        case status, message, meta
        case txRef = "tx_ref"
    }
}

// MARK: - Meta
struct BankTransferMeta: Codable {
    let authorization: BankTransferAuthorization?
}

// MARK: - Authorization
struct BankTransferAuthorization: Codable {
    let transferReference, transferAccount, transferBank, accountExpiration: String?
    let transferNote: String?
    let transferAmount: Int?
    let mode: String?

    enum CodingKeys: String, CodingKey {
        case transferReference = "transfer_reference"
        case transferAccount = "transfer_account"
        case transferBank = "transfer_bank"
        case accountExpiration = "account_expiration"
        case transferNote = "transfer_note"
        case transferAmount = "transfer_amount"
        case mode
    }
}


