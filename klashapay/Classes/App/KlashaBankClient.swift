//
//  KlashaBankClient.swift
//  klashapay
//
//  Created by Adegoke Ayomikun on 05/07/2021.
//

import Foundation
import UIKit
import Swinject
import SwinjectAutoregistration

class KlashaBankClient{
    static let sharedBankClient: KlashaBankClient = Container.sharedContainer.resolve(KlashaBankClient.self)!
    
    //MARK: Bank Transfer
    public func bankTransfer(amount: String?){
        BankViewModel.sharedViewModel.bankTransfer(amount: amount!)
    }
}
