import Foundation
import UIKit

enum MobileMoneyType{
    case ghana
    case uganda
    case rwanda
    case zambia
    case franco
}

class KlashaMobileMoneyClient {
    public var amount:String?
    public var phoneNumber:String?
    public var email:String? = ""
    public var voucher:String?
    public var network:String?
    public var selectedMobileNetwork:String?
    typealias FeeSuccessHandler = ((String?,String?) -> Void)
    typealias PendingHandler = ((String?,String?) -> Void)
    typealias ErrorHandler = ((String?,[String:Any]?) -> Void)
    typealias SuccessHandler = ((String?,FlutterwaveDataResponse?) -> Void)
    typealias WebAuthHandler = ((String,String) -> Void)
    public var error:ErrorHandler?
    public var feeSuccess:FeeSuccessHandler?
    public var transactionReference:String?
    public var chargeSuccess: SuccessHandler?
    public var chargePending: PendingHandler?
    public var chargeWebAuth: WebAuthHandler?
    public var mobileMoneyType:MobileMoneyType = .ghana
    

    public func chargeMobileMoney(_ type:MobileMoneyType = .ghana){
        var country :String = ""
        switch KlashaConfig.sharedConfig().currencyCode {
                   case "KES","TZS","GHS","ZAR":
                       country = KlashaConfig.sharedConfig().country
                   default:
                       country = "NG"
                   }
        if let pubkey = KlashaConfig.sharedConfig().publicKey{
            var param:[String:Any] = [
                "PBFPubKey": pubkey,
                "amount": amount!,
                "email": email!,
                "phonenumber":phoneNumber ?? "",
                "currency": KlashaConfig.sharedConfig().currencyCode,
                "firstname":KlashaConfig.sharedConfig().firstName ?? "",
                "lastname": KlashaConfig.sharedConfig().lastName ?? "",
                "country":country,
                "meta":"",
                "IP": getIFAddresses().first!,
                "txRef": transactionReference!,
                "orderRef": transactionReference!,
                "device_fingerprint": (UIDevice.current.identifierForVendor?.uuidString)!
            ]
            switch type{
            case .ghana :
                param.merge(["network": network ?? "","is_mobile_money_gh":"1","payment_type": "mobilemoneygh"])
            case .uganda :
                param.merge(["network": "UGX","is_mobile_money_ug":"1","payment_type": "mobilemoneyuganda"])
            case .rwanda :
                param.merge(["network": "RWF","is_mobile_money_gh":"1","payment_type": "mobilemoneygh"])
            case .zambia:
                param.merge(["network": network ?? "","is_mobile_money_ug":"1","payment_type": "mobilemoneyzambia"])
            case .franco:
                param.merge(["is_mobile_money_franco":"1","payment_type": "mobilemoneyfranco"])
            }
            
            if let _voucher = self.voucher , _voucher != ""{
                param.merge(["voucher":_voucher])
            }
            let jsonString  = param.jsonStringify()
            let secret = KlashaConfig.sharedConfig().encryptionKey!
            let data =  TripleDES.encrypt(string: jsonString, key:secret)
            let base64String = data?.base64EncodedString()
            
            let reqbody = [
                "PBFPubKey": pubkey,
                "client": base64String!, // Encrypted $data payload here.
                "alg": "3DES-24"
            ]
        }
    }
}
