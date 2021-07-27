//
//  KlashaWalletPayViewController.swift
//  klashapay
//
//  Created by Adegoke Ayomikun on 09/07/2021.
//

import UIKit
import PopupDialog

class KlashaWalletPayViewController: BaseViewController {
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    var amount: String?
    var rate : Double = 456
    var paymentType: String = "woo"
    var sourceCurrency: String = "USD"
    var destinationCurrency: String = "NGN"
    var phoneNumber: String = "09034354556"
    var txRef: String = "trial-qase-qazs-bhnm-fgfgfj-qwe32OI9HKH"
    var sourceAmount : String = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAmountAndEmail()
        setUpObservers()
    }
    
    @IBAction func onPayButtonClicked(_ sender: Any) {
        self.view.endEditing(true)
        guard let _amount = amount else {
            return
        }
        
        KlashaWalletClient.sharedWalletClient.getExchangeRate(request: GetExchangeRateRequest(sourceCurrency: sourceCurrency, amount: amount, email: KlashaConfig.sharedConfig().email ?? "", phone: phoneNumber, destinationCurrency: destinationCurrency))
    }
    
    func displayAmountAndEmail(){
        emailLabel.text = KlashaConfig.sharedConfig().email
        emailLabel.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(16))
        amountLabel.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(16))
        amountLabel.text = "\(self.amount?.toCountryCurrency(code: KlashaConfig.sharedConfig().currencyCode) ?? "")"
    }
}

extension KlashaWalletPayViewController {
    
    func setUpObservers(){
        setUpLoading()
        setUpNextActionObservers()
        setUpErrorObservers()
    }
    
    func setUpNextActionObservers(){
        PaymentServicesViewModel.sharedViewModel.exchangeRateResponse.subscribe(onNext: {[self] response in
            assert(response.destinationCurrency != nil)
            destinationCurrency = response.destinationCurrency!
            rate = response.rate!
            sourceAmount = amount!
            amount = String(response.amount! / 100)
            KlashaWalletClient.sharedWalletClient.payWithKlashaWallet(request: KlashaWalletMakePaymentRequest(currency: destinationCurrency, amount: amount!, rate: Int(rate), paymentType: paymentType, sourceCurrency: sourceCurrency, sourceAmount: sourceAmount, rememberMe: true, phoneNumber: phoneNumber, fullname: "\( KlashaWalletClient.sharedWalletClient.lastName ?? "") \(KlashaWalletClient.sharedWalletClient.firstName ?? "")" , txRef: txRef, email: KlashaConfig.sharedConfig().email ?? ""))
        }).disposed(by: disposableBag)
        
        PaymentServicesViewModel.sharedViewModel.payWithKlashaWalletResponse.subscribe(onNext: { [self] response in
            let contentVC = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "PaymentStatusPopupViewController") as! PaymentStatusPopupViewController
            contentVC.klashaWalletPaymentResponse = response
            DispatchQueue.main.async {
                let popup = PopupDialog(viewController: contentVC, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false)
                self.present(popup, animated: true, completion: nil)
            }
        }).disposed(by: disposableBag)
    }
    
    func setUpLoading(){
        setUpLoadingObservers(baseViewModel: PaymentServicesViewModel.sharedViewModel)
    }
    
    func setUpErrorObservers(){
        PaymentServicesViewModel.sharedViewModel.error.subscribe(onNext: { errorMessage in
            DispatchQueue.main.async {
                KlashaWalletClient.sharedWalletClient.error!(errorMessage,nil)
            }
        }).disposed(by: disposableBag)
    }
}

