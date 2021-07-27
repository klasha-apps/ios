//
//  CardDetailsViewController.swift
//  IQKeyboardManagerSwift
//
//  Created by Adegoke Ayomikun on 03/07/2021.
//

import UIKit
import MaterialComponents
import RxSwift

public class CardDetailsViewController: BaseViewController, KlashaPayWebProtocol {
    func tranasctionSuccessful(flwRef: String, responseData: FlutterwaveDataResponse?) {
        print("Success")
    }
    
    @IBOutlet weak var payWithLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cardCvvTextField: MDCOutlinedTextField!
    @IBOutlet weak var cardExpTextField: MDCOutlinedTextField!
    @IBOutlet weak var cardNumberTextField: MDCOutlinedTextField!
    @IBOutlet weak var payBtnView: UIView!
    var amount : String?
    public var disposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        setCustomFont()
        configureDebitCardView()
        styleTextFields()
        setUpObservers()
        payBtnView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPayBtnClicked)))
        displayAmountAndEmail()
    }
    
    func setCustomFont(){
        amountLabel.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(18))
        emailLabel.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(18))
        cardCvvTextField.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        cardExpTextField.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        cardNumberTextField.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        payWithLabel.font = Fonts.podFont(name: "Bolds.ttf", size: CGFloat(20))
    }
    
    
    func displayAmountAndEmail(){
        emailLabel.text = KlashaConfig.sharedConfig().email
        amountLabel.text = "\(self.amount?.toCountryCurrency(code: KlashaConfig.sharedConfig().currencyCode) ?? "")"
    }
    
    @objc func onPayBtnClicked(){
        let expiryValidator = ValidatorType.cardMonth
        let carrdValidator = ValidatorType.card
        let cardValid = cardNumberTextField.validateAndShowError2(validationType: carrdValidator)
        let expiryValid = cardExpTextField.validateAndShowError(validationType: expiryValidator)
        let cvvValid = cardCvvTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "CVV"))
        
        if(cardValid && expiryValid && cvvValid ){
            self.cardPayAction()
        }
        
    }
    
    func cardPayAction(){
        self.view.endEditing(true)
        KlashaCardClient.sharedCardClient.cardNumber = self.cardNumberTextField.text?.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
        
        //        print("SDK VALUE \(flutterwaveCardClient.cardNumber.orEmpty())")
        KlashaCardClient.sharedCardClient.cvv = cardCvvTextField.text
        
        let seperateCardExpiry = cardExpTextField.text?.split(separator: "/")
        
        KlashaCardClient.sharedCardClient.expMonth = String((seperateCardExpiry![0]))
        KlashaCardClient.sharedCardClient.expYear = String((seperateCardExpiry![1]))
        
        KlashaCardClient.sharedCardClient.amount = self.amount
        KlashaCardClient.sharedCardClient.sendCardPayment()
        
    }
    
    func styleTextFields(){
        cardCvvTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        cardCvvTextField.label.text = "CVV"
        cardCvvTextField.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        cardCvvTextField.setFloatingLabelColor(.black, for: .normal)
        cardCvvTextField.setFloatingLabelColor(.black, for: .editing)
        cardCvvTextField.tintColor = .lightGray
        cardCvvTextField.setNormalLabelColor(.lightGray, for: .normal)
        cardCvvTextField.setTextColor(.black, for: .editing)
        cardCvvTextField.setTextColor(.black, for: .normal)
        cardCvvTextField.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.4), for: .normal)
        cardCvvTextField.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
        cardCvvTextField.translatesAutoresizingMaskIntoConstraints = false
        cardCvvTextField.keyboardType = .numberPad
        
        cardExpTextField.label.text = "Expiry Date"
        cardExpTextField.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        cardExpTextField.setFloatingLabelColor(.black, for: .normal)
        cardExpTextField.setFloatingLabelColor(.black, for: .editing)
        cardExpTextField.tintColor = .lightGray
        cardExpTextField.setNormalLabelColor(.lightGray, for: .normal)
        cardExpTextField.setTextColor(.black, for: .editing)
        cardExpTextField.setTextColor(.black, for: .normal)
        cardExpTextField.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.4), for: .normal)
        cardExpTextField.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
        cardExpTextField.translatesAutoresizingMaskIntoConstraints = false
        cardExpTextField.keyboardType = .numberPad
        
        cardNumberTextField.label.text = "Card Number"
        cardNumberTextField.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        cardNumberTextField.setFloatingLabelColor(.black, for: .normal)
        cardNumberTextField.setFloatingLabelColor(.black, for: .editing)
        cardNumberTextField.tintColor = .lightGray
        cardNumberTextField.setNormalLabelColor(.lightGray, for: .normal)
        cardNumberTextField.setTextColor(.black, for: .editing)
        cardNumberTextField.setTextColor(.black, for: .normal)
        cardNumberTextField.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.4), for: .normal)
        cardNumberTextField.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
        cardNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        cardNumberTextField.keyboardType = .numberPad
    }
    
    func configureDebitCardView(){
        //Validate Expiry Date
        //Limit cvv texfield character
        cardCvvTextField.rx.text.orEmpty
            .map { String($0.prefix(3)) }
            .bind(to: cardCvvTextField.rx.text)
            .disposed(by: disposeBag)
        
        //Limit expiry texfield character
        cardExpTextField.rx.text.orEmpty
            .map { String($0.prefix(5)) }
            .bind(to: cardExpTextField.rx.text)
            .disposed(by: disposeBag)
        
        cardNumberTextField.rx.text.orEmpty
            .map { String($0.prefix(24)) }
            .bind(to: cardNumberTextField.rx.text)
            .disposed(by: disposeBag)
        
        
        let cardValidator = ValidatorType.card
        cardNumberTextField.watchText2(validationType: cardValidator, disposeBag: disposeBag)
        
        cardCvvTextField.watchText(validationType: ValidatorType.requiredField(field: "CVV"), disposeBag: disposeBag)
        
        let expiryValidator = ValidatorType.cardMonth
        cardExpTextField.watchText(validationType: expiryValidator, disposeBag: disposeBag)
        
        //MARK Format expiry month-year texfield
        cardExpTextField.rx.text.changed.subscribe(onNext: { [self] input in
            cardExpTextField.formatTextToSlash(textPattern:"##/##")
        }).disposed(by: disposeBag)
        
        cardNumberTextField.rx.text.changed.subscribe(onNext: { input in
            self.cardNumberTextField.formatTextToSpace(textPattern: "#### #### #### #### ###")
        }).disposed(by: disposeBag)
    }
}

extension CardDetailsViewController {
    
    func setUpObservers(){
        setUpLoading()
        setUpNextActionObservers()
        setUpErrorObservers()
    }
    
    func setUpNextActionObservers(){
        PaymentServicesViewModel.sharedViewModel.moveToPin.subscribe(onNext: { response in
            let controller = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "CardPinViewController") as! CardPinViewController
            KlashaCardClient.sharedCardClient.transactionReference = response.txRef
          
            self.navigationController?.pushViewController(controller, animated: true)
        } ).disposed(by: disposeBag)
        
        PaymentServicesViewModel.sharedViewModel.moveToWebView.subscribe(onNext: { response in
            let ref = response.data?.flwRef.orEmpty()
            self.showWebView(url: response.data?.meta?.authorization?.redirect.orEmpty(),ref:ref)
        } ).disposed(by: disposeBag)
        
        PaymentServicesViewModel.sharedViewModel.moveToAddressVerification.subscribe(onNext: {response in
            let controller = BillingAddressViewController()
           // KlashaCardClient.sharedCardClient.transactionReference = response.txRef
            self.navigationController?.pushViewController(controller, animated: true)
        }).disposed(by: disposableBag)
    }
    
    func setUpLoading(){
        setUpLoadingObservers(baseViewModel: PaymentServicesViewModel.sharedViewModel)
    }
    
    func setUpErrorObservers(){
        PaymentServicesViewModel.sharedViewModel.error.subscribe(onNext: { errorMessage in
            DispatchQueue.main.async {
                //showSnackBarWithMessage(msg: errorMessage, style: .error)
                KlashaCardClient.sharedCardClient.error!(errorMessage,nil)
            }
            
        }).disposed(by: disposableBag)
    }
}

extension CardDetailsViewController{
    func showWebView(url: String?,ref:String?){
        //Collapse opened Tabs
       // self.handelCloseOrExpandSection(section: 0)
        //Show web view
        //let storyBoard = UIStoryboard(name: "Rave", bundle: nil)
        let controller = KlashaPayWebViewController()
        controller.flwRef = ref
        controller.url = url
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
}




