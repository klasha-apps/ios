//
//  KlashaWalletClient.swift
//  klashapay
//
//  Created by Adegoke Ayomikun on 10/07/2021.
//

import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

class KlashaWalletClient{
    public var username:String?
    public var password:String?
    public var firstName:String?
    public var lastName:String?
    
    
    typealias LoginSuccess = ((String?, KlashaWalletLoginResponse?) -> Void)
    typealias LoginError = ((String?, KlashaWalletLoginResponse?) -> Void)
    typealias SuccessHandler = ((String?,KlashaWalletMakePaymentResponse?) -> Void)
    
    public var loginSuccess:LoginSuccess?
    public var error:LoginError?
    public var chargeSuccess: SuccessHandler?
  
   
    static let sharedWalletClient: KlashaWalletClient = Container.sharedContainer.resolve(KlashaWalletClient.self)!
    
    //MARK: Login
    public func login(username: String?, password: String?){
        guard let username = username, let _password = password else {
            self.error?("Username/Password is not set",nil)
            return
        }
        PaymentServicesViewModel.sharedViewModel.klashaWalletLogin(request: KlashaWalletLoginRequest(username: username, password: _password))
    }
    
    public func getExchangeRate(request: GetExchangeRateRequest){
        PaymentServicesViewModel.sharedViewModel.getExchangeRate(request: GetExchangeRateRequest(sourceCurrency: request.sourceCurrency, amount: request.amount, email: request.email, phone: request.phone, destinationCurrency: request.destinationCurrency))
    }
    
    public func payWithKlashaWallet(request: KlashaWalletMakePaymentRequest){
        PaymentServicesViewModel.sharedViewModel.payWithKlashaWallet(request: KlashaWalletMakePaymentRequest(currency: request.currency, amount: request.amount, rate: request.rate, paymentType: request.paymentType, sourceCurrency: request.sourceCurrency, sourceAmount: request.sourceAmount, rememberMe: request.rememberMe, phoneNumber: request.phoneNumber, fullname: request.fullname, txRef: request.txRef, email: request.email))
    }
}
