//
//  PayWithBankViewController.swift
//  klashapay
//
//  Created by Adegoke Ayomikun on 05/07/2021.
//

import UIKit
import MaterialComponents

class PayWithBankViewController: BaseViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var bankNameTextField: MDCOutlinedTextField!
    
    @IBOutlet weak var accountNumberTextField: MDCOutlinedTextField!
    
    @IBOutlet weak var payWithLabel: UILabel!
    
    @IBOutlet weak var headerLabel: UILabel!
    var bankTransferResponse: BankTransferResponse?
    var amount: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAmountAndEmail()
        styleTextFields()
        initTextFields()
    }

    
    @IBAction func confirmTransferClicked(_ sender: Any) {
        
    }
}

extension PayWithBankViewController{
    
    func displayAmountAndEmail(){
        emailLabel.text = KlashaConfig.sharedConfig().email
        amountLabel.text = "\(self.amount?.toCountryCurrency(code: KlashaConfig.sharedConfig().currencyCode) ?? "")"
        emailLabel.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(18))
        amountLabel.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(18))
        payWithLabel.font = Fonts.podFont(name: "Bolds.ttf", size: CGFloat(20))
    }
    
    func initTextFields(){
        bankNameTextField.text = bankTransferResponse?.meta?.authorization?.transferBank
        accountNumberTextField.text = bankTransferResponse?.meta?.authorization?.transferAccount
    }
    
    func styleTextFields(){
        bankNameTextField.backgroundColor = UIColor.lightGray
        bankNameTextField.label.text = "Bank Name"
        bankNameTextField.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        bankNameTextField.setFloatingLabelColor(.black, for: .normal)
        bankNameTextField.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        bankNameTextField.tintColor = .lightGray
        bankNameTextField.setNormalLabelColor(.lightGray, for: .normal)
        bankNameTextField.setTextColor(.black, for: .normal)
        bankNameTextField.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.17), for: .normal)
        bankNameTextField.translatesAutoresizingMaskIntoConstraints = false
        bankNameTextField.isEnabled = false
        
        accountNumberTextField.backgroundColor = UIColor.lightGray
        accountNumberTextField.label.text = "Account Number"
        accountNumberTextField.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        accountNumberTextField.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        accountNumberTextField.setFloatingLabelColor(.black, for: .normal)
        accountNumberTextField.tintColor = .lightGray
        accountNumberTextField.setNormalLabelColor(.lightGray, for: .normal)
        accountNumberTextField.setTextColor(.black, for: .normal)
        accountNumberTextField.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.17), for: .normal)
        accountNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        accountNumberTextField.keyboardType = .numberPad
        accountNumberTextField.isEnabled = false
    }
}
