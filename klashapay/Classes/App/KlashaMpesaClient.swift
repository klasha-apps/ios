//
//  KlashaMpesaClient.swift
//  klashapay
//
//  Created by Adegoke Ayomikun on 26/07/2021.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class KlashaMpesaClient{
    public var amount:String?
    public var phoneNumber:String?
    public var email:String? = ""
    public var transactionReference:String?
    
    static let sharedMpesaClient: KlashaMpesaClient = Container.sharedContainer.resolve(KlashaMpesaClient.self)!
    
    //MARK: Charge
    public func chargeMpesa(){
        if let pubkey = KlashaConfig.sharedConfig().publicKey{
            var country :String = ""
            switch KlashaConfig.sharedConfig().currencyCode {
            case "KES","TZS","GHS","ZAR":
                country = KlashaConfig.sharedConfig().country
            default:
                country = "NG"
            }
            MobileMoneyViewModel.sharedViewModel.mpesaMoney(amount: amount!, phoneNumber: phoneNumber ?? "")
        }
    }
}
