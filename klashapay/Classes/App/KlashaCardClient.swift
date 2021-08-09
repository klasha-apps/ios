import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

class KlashaCardClient{
    
    static let sharedCardClient: KlashaCardClient = Container.sharedContainer.resolve(KlashaCardClient.self)!
    
    public var cardNumber:String?
    public var cardfirst6:String?
    public var cvv:String?
    public var amount:String?
    public var expYear:String?
    public var expMonth:String?
    public var otp:String?
    public var pin:String?
    public var address:String?
    public var state:String?
    public var country:String?
    public var zipCode:String?
    
    public var transactionReference:String?
    public var flwReference :String?
    public var bodyParam:[String:Any]? = [:]
    
    typealias FeeSuccessHandler = ((String?,String?) -> Void)
    typealias SuccessHandler = ((String?,ValidateCardPaymentResponse?) -> Void)
    typealias ErrorHandler = ((String?, SendCardPaymentResponse?) -> Void)
    typealias SuggestedAuthHandler = ((SuggestedAuthModel,[String:Any]?, String?) -> Void)
    typealias OTPAuthHandler = ((String,String) -> Void)
    typealias WebAuthHandler = ((String,String) -> Void)
    
    public var error:ErrorHandler?
    public var validateError:ErrorHandler?
    public var feeSuccess:FeeSuccessHandler?
    public var chargeSuggestedAuth: SuggestedAuthHandler?
    public var chargeOTPAuth: OTPAuthHandler?
    public var chargeWebAuth: WebAuthHandler?
    public var chargeSuccess: SuccessHandler?
    
    private var isRetryCharge = false
    private var retryChargeValue:String?
    
    
    //MARK: Send Card Payment
    public func sendCardPayment(replaceData:Bool = false){
        if let pubkey = KlashaConfig.sharedConfig().publicKey{
            var country :String = ""
            switch KlashaConfig.sharedConfig().currencyCode {
            case "KES","TZS","GHS","ZAR":
                country = KlashaConfig.sharedConfig().country
            default:
                country = "NG"
            }
            guard let _ = cardNumber else {
                fatalError("Card Number is missing")
            }
            guard let _ = cvv else {
                fatalError("CVV Number is missing")
            }
            guard let _ = amount else {
                fatalError("Amount is missing")
            }
            guard let _ = expYear else {
                fatalError("Expiry Year is missing")
            }
            guard let _ = expMonth else {
                fatalError("Expiry Month is missing")
            }
            guard let _ = KlashaConfig.sharedConfig().email else {
                fatalError("Email address is missing")
            }
            guard let _ = KlashaConfig.sharedConfig().transcationRef else {
                fatalError("transactionRef is missing")
            }
            //            print("FUNCTION CARD \(cardNumber.orEmpty())")
            var param:[String:Any] = ["PBFPubKey":pubkey ,
                                      "card_number":cardNumber ?? "",
                                      "cvv":cvv ?? "",
                                      "amount":amount ?? "",
                                      "expiry_year":expYear ?? "",
                                      "expiry_month": expMonth ?? "",
                                      "fullname": "\(KlashaConfig.sharedConfig().firstName.orEmpty()) \(KlashaConfig.sharedConfig().lastName.orEmpty())",
                                      "email": KlashaConfig.sharedConfig().email!,
                                      "currency": KlashaConfig.sharedConfig().currencyCode,
                                      "country":country,
                                      //                                      "IP": getIFAddresses().first!,
                                      "tx_ref": KlashaConfig.sharedConfig().transcationRef!]
            if let narrate = KlashaConfig.sharedConfig().narration{
                param.merge(["narration":narrate])
            }
            
            if let meta = KlashaConfig.sharedConfig().meta{
                param.merge(["meta":meta])
            }
            
            if replaceData {
                bodyParam = param
            }
            if isRetryCharge{
                if let retryValue = self.retryChargeValue{
                    bodyParam?.merge(["retry_charge":retryValue])
                }
            }
            let secret = KlashaConfig.sharedConfig().encryptionKey!
            let request = SendCardPaymentRequest(cardNumber: cardNumber ?? "", cvv: cvv ?? "", expiryMonth: expMonth ?? "", expiryYear: expYear ?? "", currency: KlashaConfig.sharedConfig().currencyCode, country: country, amount: amount ?? "", rate: 6.3, paymentType: "woo", businessID: 1, sourceCurrency: "NGN", sourceAmount: 0.0023, rememberMe: true, phoneNumber: "080344006699", email: "ola@klasha.com", fullname: "yemi desola", txRef: "test910-on2007u047e-291076", redirectURL: "https://165.232.102.181:7701/pay/ravecallback")
            
            PaymentServicesViewModel.sharedViewModel.sendCardPayment(request: request)
        }else{
            self.error?("Public Key is not specified", nil)
        }
    }
    
    //MARK: Charge Card
    public func chargeCard(){
        guard let ref = self.transactionReference, let _pin = self.pin else {
            self.error?("Transaction Reference  or Pin is not set",nil)
            return
        }
        PaymentServicesViewModel.sharedViewModel.chargeCard(request: ChargeCardRequest(mode: "pin", pin: _pin, txRef: ref))
    }
    
    //MARK: Validate Card
    public func validateCardOTP(){
        guard let ref = self.flwReference, let _otp = self.otp else {
            self.error?("Transaction Reference  or OTP is not set",nil)
            return
        }
        PaymentServicesViewModel.sharedViewModel.validateCardPayment(otp: _otp, flwRef: ref, type: "card")
    }
    
    func isMasterCard() -> Bool{
        if let cardNumber = self.cardNumber{
            if cardNumber.hasPrefix("5"){
                return true
            }else{
                return false
            }
        }else{
            return false
        }
    }
}
