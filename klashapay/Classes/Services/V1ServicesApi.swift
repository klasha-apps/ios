import Foundation

enum VersionOneServicesApi{
    case sendCardPayment
    case chargeCard
    case validateCardPayment
    case bankTransfer
    case klashaWalletLogin
    case payWithKlashaWallet
    case exchangeRate
    case mpesa
    case ussd
    case ghanaMoney
}

enum Gateway{
    case nigeria
    case kenya
    case ghana
}

enum MonitorAPIService {
    case monitor
}


extension VersionOneServicesApi:EndpointType{
    var stagingURL: URL {
        return URL(string: "https://ktests.com/")!
    }
    
    var baseURL: URL {
       return URL(string: "https://gate.klasapps.com/")!
    }
    

    var path: String {
        switch self {
        case .sendCardPayment:
            return "pay/NGN/cardpayment"
        case .chargeCard:
            return "pay/NGN/charge"
        case .validateCardPayment:
            return "pay/NGN/validatepayment"
        case .bankTransfer:
            return "pay/NGN/banktransfer"
        case .klashaWalletLogin:
            return "pay/wallet/popup"
        case .payWithKlashaWallet:
            return "pay/wallet/makePayment"
        case .exchangeRate:
            return "nucleus/exchange/"
        case .ghanaMoney:
            return "pay/GHS/mobilemoney"
        case .mpesa:
            return "pay/KES/cardpayment"
        case .ussd:
            return "pay/NGN/ussd"
        }
    }
}




