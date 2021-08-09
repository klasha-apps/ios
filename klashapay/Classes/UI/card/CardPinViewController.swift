//
//  CardPinViewController.swift
//  IQKeyboardManagerSwift
//
//  Created by Adegoke Ayomikun on 03/07/2021.
//

import UIKit
import OTPFieldView
import RxSwift

class CardPinViewController: BaseViewController, OTPFieldViewDelegate {
    
    public var disposeBag = DisposeBag()
  
    @IBOutlet weak var payWithLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var continueBtn: UIButton!
    var pinString: String?
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        pinString = otp
    }
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        if hasEnteredAll{
           enableContinueBtn()
        }else{
          disableContinueBtn()
        }
        return hasEnteredAll
    }
    
    func disableContinueBtn(){
        continueBtn.isEnabled = false
        continueBtn.backgroundColor = KlashaConstants.klashaPink.withAlphaComponent(0.5)
    }
    
    func enableContinueBtn(){
        continueBtn.isEnabled = true
        continueBtn.backgroundColor = KlashaConstants.klashaPink
    }
    

    @IBOutlet weak var pinTextField: OTPFieldView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        setUpObservers()
        disableContinueBtn()
        configurePinTextField()
        payWithLabel.textColor = UIColor.lightGray
        payWithLabel.font = Fonts.podFont(name: "Bolds.ttf", size: CGFloat(20))
        headerLabel.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(18))
        continueBtn.titleLabel?.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(15))
    }
    
    func configurePinTextField(){
        pinTextField.fieldsCount = 4
        pinTextField.cursorColor = KlashaConstants.klashaPink
        pinTextField.filledBorderColor = KlashaConstants.klashaPink
        pinTextField.filledBackgroundColor = KlashaConstants.klashaLightPink
        pinTextField.separatorSpace = 8
        pinTextField.fieldSize = 40
        pinTextField.shouldAllowIntermediateEditing = false
        pinTextField.displayType = .roundedCorner
        pinTextField.fieldBorderWidth = 2
        pinTextField.defaultBorderColor = UIColor.lightGray
        pinTextField.otpInputType = .numeric
        pinTextField.secureEntry = true
        pinTextField.delegate = self
        pinTextField.initializeUI()
    }
    
    
    @IBAction func onContinueBtnClicked(_ sender: Any) {
        KlashaCardClient.sharedCardClient.pin = pinString
        KlashaCardClient.sharedCardClient.chargeCard()
    }
}

extension CardPinViewController {
    
    func setUpObservers(){
        setUpLoading()
        setUpNextActionObserver()
        setUpErrorObservers()
    }
    
    func setUpNextActionObserver(){
        PaymentServicesViewModel.sharedViewModel.chargeCardResponse.subscribe(onNext: { response in
            let controller = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "CardOTPViewController") as! CardOTPViewController
            controller.instructionString = response.message
            self.navigationController?.pushViewController(controller, animated: true)
        } ).disposed(by: disposeBag)
    }
    
    func setUpLoading(){
        setUpLoadingObservers(baseViewModel: PaymentServicesViewModel.sharedViewModel)
    }
    
    func setUpErrorObservers(){
        PaymentServicesViewModel.sharedViewModel.error.subscribe(onNext: { errorMessage in
            DispatchQueue.main.async {
                KlashaCardClient.sharedCardClient.error!(errorMessage,nil)
            }
        }).disposed(by: disposableBag)
    }
}

