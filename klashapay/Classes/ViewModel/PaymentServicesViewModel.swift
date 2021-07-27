import UIKit

import Foundation
import RxSwift
import Swinject

class PaymentServicesViewModel: BaseViewModel{
    
    static let sharedViewModel: PaymentServicesViewModel = Container.sharedContainer.resolve(PaymentServicesViewModel.self)!
    
    let paymentServicesRepository: PaymentServicesRepository
    let moveToPin = PublishSubject<SendCardPaymentResponse>()
   // let moveToOTP = PublishSubject<SendCardPaymentResponse>()
    let moveToWebView = PublishSubject<SendCardPaymentResponse>()
    let moveToAddressVerification = PublishSubject<SendCardPaymentResponse>()
    let chargeCardResponse = PublishSubject<ChargeCardResponse>()
    let sendCardPaymentResponse = PublishSubject<SendCardPaymentResponse>()
    let klashaWalletLoginResponse = PublishSubject<KlashaWalletLoginResponse>()
    let payWithKlashaWalletResponse = PublishSubject<KlashaWalletMakePaymentResponse>()
    let exchangeRateResponse = PublishSubject<GetExchangeRateResponse>()
    let validateCardPayment = PublishSubject<ValidateCardPaymentResponse>()
    let mpesaVerifyResponse = PublishSubject<MpesaVerifyResponse>()
    let pwbtVerifyResponse = PublishSubject<PwbtVerifyResponse>()
    var flwRef = ""
    var txRef = ""
    
    let pendingTransactionAlert =  PublishSubject<String>()
    var retryCount = 0
    var pwtRetryCount = 0
    init(paymentServicesRepository: PaymentServicesRepository){
        self.paymentServicesRepository = paymentServicesRepository
    }
    
    func sendCardPayment(request: SendCardPaymentRequest) {
        makeAPICallRx(request: request, apiRequest: paymentServicesRepository.sendCardPayment(request:), successHandler: sendCardPaymentResponse,onSuccessOperation: {response in
            let authMode = response.data?.meta?.authorization?.mode ?? ""
            switch authMode{
            case "pin":
                self.moveToPin.onNext(response)
         //   case "otp":
               // self.moveToOTP.onNext(response)
            case "redirect":
                self.moveToWebView.onNext(response)
            case "avs_noauth":
                self.moveToAddressVerification.onNext(response)
            default:
                break
            }
            
        },apiName: .initCardCharge,apiErrorName: .initCardChargeError)
    }
    
    
    func chargeCard(request: ChargeCardRequest) {
        makeAPICallRx(request: request, apiRequest: paymentServicesRepository.chargeCard(request:), successHandler: chargeCardResponse,onSuccessOperation: {response in
            KlashaCardClient.sharedCardClient.flwReference = response.flwRef
        })
    }
    
    func validateCardPayment(otp: String, flwRef: String, type:String) {
        let request = ValidateCardPaymentRequest(otp: otp, flwRef:flwRef, type:type)
        makeAPICallRx(request: request, apiRequest: paymentServicesRepository.validateCardPayment(request:), successHandler: validateCardPayment,onSuccessOperation: { response in
            self.flwRef = response.txRef ?? ""
        })
    }
    
    func klashaWalletLogin(request: KlashaWalletLoginRequest) {
        makeAPICallRx(request: request, apiRequest: paymentServicesRepository.klashaWalletLogin(request:), successHandler: klashaWalletLoginResponse,onSuccessOperation: { response in
            KlashaWalletClient.sharedWalletClient.firstName = response.firstName
            KlashaWalletClient.sharedWalletClient.lastName = response.lastName
        })
    }
    
    func payWithKlashaWallet(request: KlashaWalletMakePaymentRequest) {
        makeAPICallRx(request: request, apiRequest: paymentServicesRepository.payWithKlashaWallet(request:), successHandler: payWithKlashaWalletResponse,onSuccessOperation: { response in
            
        })
    }
    
    func getExchangeRate(request: GetExchangeRateRequest) {
        makeAPICallRx(request: request, apiRequest: paymentServicesRepository.getExchangeRate(request:), successHandler: exchangeRateResponse,onSuccessOperation: { response in
        })
    }
    
    private func handleRetry(currentRetryCount:Int,flwRef:String){
        let seconds = 10.0
        let maxRetryCount = 10
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            if(currentRetryCount != maxRetryCount){
              //  PaymentServicesViewModel.sharedViewModel.mpesaVerify(flwRef: flwRef)
                PaymentServicesViewModel.sharedViewModel.retryCount += 1
                self.pendingTransactionAlert.onNext("Your transaction is still pending try again")
            }else{
                self.isLoading.onNext(false)
               
                PaymentServicesViewModel.sharedViewModel.retryCount = 0
                self.pendingTransactionAlert.onNext("Your transaction is still pending try again")
                
            }
        }
    }
}

enum PaymentState:String {
    case PENDING = "pending"
    case SUCCESS = "successful"
    case FAILED = "failed"
    case SUCCESS2 = "success"
}

