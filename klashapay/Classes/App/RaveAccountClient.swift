import Foundation
import UIKit
class FlutterwaveAccountClient {
    public var amount:String?
    public var accountNumber:String?
    public var bankCode:String?
    public var phoneNumber:String?
    public var passcode:String?
    public var bvn:String?
    public var isInternetBanking:Bool = false
    public var blacklistedBankCodes:[String]?
    public var isUSBankAccount =  false
    
    typealias BanksHandler = (([Bank]?) -> Void)
    typealias ErrorHandler = ((String?,FlutterwaveDataResponse?) -> Void)
    typealias FeeSuccessHandler = ((String?,String?) -> Void)
    typealias SuccessHandler = ((String?,FlutterwaveDataResponse?) -> Void)
    public var banks: BanksHandler?
    public var error:ErrorHandler?
    public var validateError:ErrorHandler?
    public var feeSuccess:FeeSuccessHandler?
    public var chargeSuccess: SuccessHandler?
    typealias OTPAuthHandler = ((String,String) -> Void)
    typealias WebAuthHandler = ((String,String) -> Void)
    typealias GBPOTPAuthHandler = ((String,String,String) -> Void)
    public var chargeOTPAuth: OTPAuthHandler?
    public var redoChargeOTPAuth: OTPAuthHandler?
    public var chargeGBPOTPAuth: GBPOTPAuthHandler?
    public var chargeWebAuth: WebAuthHandler?
    public var otp:String?
    public var transactionReference:String?
    var txRef:String?
    var chargeAmount:String?
    var accountform = AccountForm()
//    //MARK: Fee
//    public func getFee(){
//        if let pubkey = FlutterwaveConfig.sharedConfig().publicKey{
//            let param = [
//                "PBFPubKey": pubkey,
//                "amount": amount!,
//                "currency": FlutterwaveConfig.sharedConfig().currencyCode,
//                "ptype": "2"]
//            FlutterwavePayService.getFee(param, resultCallback: { (result) in
//                let data = result?["data"] as? [String:AnyObject]
//                if let _fee =  data?["fee"] as? Double{
//                    let fee = "\(_fee)"
//                    let chargeAmount = data?["charge_amount"] as? String
//                    self.feeSuccess?(fee,chargeAmount)
//                }else{
//                    if let err = result?["message"] as? String{
//                        self.error?(err,nil)
//                    }
//                }
//            }, errorCallback: { (err) in
//                
//                self.error?(err,nil)
//            })
//        }else{
//            self.error?("Public Key is not specified",nil)
//        }
//    }
    
    //MARK: Bank List
//    public func getBanks(){
//        var banks:[Bank]? = []
//        FlutterwavePayService.getBanks(resultCallback: { (_banks) in
//            DispatchQueue.main.async {
//                var _thebanks:[Bank]? = _banks
//                if let count = self.blacklistedBankCodes?.count{
//                    if count > 0 {
//                        self.blacklistedBankCodes?.forEach({ (code) in
//                            _thebanks = _thebanks?.filter({ (bank) -> Bool in
//                                return  bank.bankCode! != code
//                            })
//                        })
//                        banks = _thebanks
//                        banks = banks?.sorted(by: { (first, second) -> Bool in
//                            return first.name!.localizedCaseInsensitiveCompare(second.name!) == .orderedAscending
//                        })
//                        self.banks?(banks)
//                    }else{
//                        banks = _banks?.sorted(by: { (first, second) -> Bool in
//                            return first.name!.localizedCaseInsensitiveCompare(second.name!) == .orderedAscending
//                        })
//                        self.banks?(banks)
//                    }
//                }else{
//                    banks = _banks?.sorted(by: { (first, second) -> Bool in
//                        return first.name!.localizedCaseInsensitiveCompare(second.name!) == .orderedAscending
//                    })
//                    self.banks?(banks)
//                }
//            }
//            
//        }) { (err) in
//            //            print(err)
//        }
//        
//    }
    //MARK: Charge
    public func chargeAccount(){
        if let pubkey = KlashaConfig.sharedConfig().publicKey{
            let isInternetBanking = (self.isInternetBanking) == true ? 1 : 0
            var country :String = ""
            switch KlashaConfig.sharedConfig().currencyCode {
            case "KES","TZS","GHS","ZAR":
                country = KlashaConfig.sharedConfig().country
            default:
                country = "NG"
            }
            guard let _ = amount else {
                fatalError("Amount is missing")
            }
            guard let _ = phoneNumber else {
                fatalError("Mobile Number is missing")
            }
            guard let _ = KlashaConfig.sharedConfig().email else {
                fatalError("Email address is missing")
            }
            guard let _ = KlashaConfig.sharedConfig().transcationRef else {
                fatalError("transactionRef is missing")
            }
            var param:[String:Any] = [
                "PBFPubKey": pubkey,
                "amount": amount!,
                "email": KlashaConfig.sharedConfig().email!,
                "payment_type":"account",
                "phonenumber":phoneNumber!,
                "firstname":KlashaConfig.sharedConfig().firstName.orEmpty(),
                "lastname": KlashaConfig.sharedConfig().lastName.orEmpty(),
                "currency": KlashaConfig.sharedConfig().currencyCode,
                "country":country,
                "IP": getIFAddresses().first!,
                "txRef":  KlashaConfig.sharedConfig().transcationRef!,
                "device_fingerprint": (UIDevice.current.identifierForVendor?.uuidString)!
            ]
            if let accountNumber = self.accountNumber{
                param.merge(["accountnumber":accountNumber])
            }
            if let code = self.bankCode{
                param.merge(["accountbank":code])
            }
            
            if KlashaConfig.sharedConfig().isPreAuth{
                param.merge(["charge_type":"preauth"])
            }
            if let passcode = self.passcode{
                param.merge(["passcode":passcode])
            }
            if let bvn = self.bvn{
                param.merge(["bvn":bvn])
            }
            if(isInternetBanking == 1){
                param.merge(["is_internet_banking":"\(isInternetBanking)"])
            }
            if let narrate = KlashaConfig.sharedConfig().narration{
                param.merge(["narration":narrate])
            }
            if let meta = KlashaConfig.sharedConfig().meta{
                param.merge(["meta":meta])
            }
            if isUSBankAccount{
                param.merge(["is_us_bank_charge" : "\(isUSBankAccount)"])
            }
            if KlashaConfig.sharedConfig().currencyCode == "GBP"{
                param.merge(["is_uk_bank_charge2" :1, "accountname":accountNumber.orEmpty()])
            }
            
            if let subAccounts = KlashaConfig.sharedConfig().subAccounts{
                let subAccountDict =  subAccounts.map { (subAccount) -> [String:String] in
                    var dict = ["id":subAccount.id]
                    if let ratio = subAccount.ratio{
                        dict.merge(["transaction_split_ratio":"\(ratio)"])
                    }
                    if let chargeType = subAccount.charge_type{
                        switch chargeType{
                        case .flat :
                            dict.merge(["transaction_charge_type":"flat"])
                            if let charge = subAccount.charge{
                                dict.merge(["transaction_charge":"\(charge)"])
                            }
                        case .percentage:
                            dict.merge(["transaction_charge_type":"percentage"])
                            if let charge = subAccount.charge{
                                dict.merge(["transaction_charge":"\((charge / 100))"])
                            }
                        }
                    }
                    
                    return dict
                }
                param.merge(["subaccounts":subAccountDict])
            }
            
            
            if(KlashaConfig.sharedConfig().currencyCode == "NGN"){
                BankViewModel.sharedViewModel.nigeriaBankTransfer(amount: self.amount.orEmpty(), accountBank: self.bankCode.orEmpty(), accountNumber: self.accountNumber.orEmpty(), phoneNumber: phoneNumber.orEmpty(), passCode: passcode.orEmpty(), bvn: bvn.orEmpty())
            }
            
            //            let jsonString  = param.jsonStringify()
            //            let secret = RaveConfig.sharedConfig().encryptionKey!
            //            let data =  TripleDES.encrypt(string: jsonString, key:secret)
            //            let base64String = data?.base64EncodedString()
            
        }
    }
    
    
    
}
