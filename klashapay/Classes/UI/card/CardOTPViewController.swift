//
//  CardOTPViewController.swift
//  IQKeyboardManagerSwift
//
//  Created by Adegoke Ayomikun on 03/07/2021.
//

import UIKit
import OTPFieldView
import RxSwift
import PopupDialog

class CardOTPViewController: BaseViewController, OTPFieldViewDelegate {
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var otpTextField: OTPFieldView!
    @IBOutlet weak var payWithLabel: UILabel!
    var otpString: String?
    public var instructionString: String?
    let disposeBag = DisposeBag()
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        otpString = otp
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        instructionLabel.text = instructionString!
        setUpObservers()
        configureOtpTextField()
        payWithLabel.textColor = UIColor.lightGray
        payWithLabel.font = Fonts.podFont(name: "Bolds.ttf", size: CGFloat(20))
    }
    
    func configureOtpTextField(){
        otpTextField.fieldsCount = 5
        otpTextField.cursorColor = KlashaConstants.klashaPink
        otpTextField.filledBorderColor = KlashaConstants.klashaPink
        otpTextField.filledBackgroundColor = KlashaConstants.klashaLightPink
        otpTextField.separatorSpace = 8
        otpTextField.fieldSize = 40
        otpTextField.shouldAllowIntermediateEditing = false
        otpTextField.displayType = .roundedCorner
        otpTextField.fieldBorderWidth = 2
        otpTextField.defaultBorderColor = UIColor.lightGray
        otpTextField.otpInputType = .numeric
        otpTextField.secureEntry = true
        otpTextField.delegate = self
        otpTextField.initializeUI()
    }
    
    @IBAction func onContinueBtnClicked(_ sender: Any) {
        KlashaCardClient.sharedCardClient.otp = otpString
        KlashaCardClient.sharedCardClient.validateCardOTP()
    }
    
}

extension CardOTPViewController {
    
    func setUpObservers(){
        setUpLoading()
        setUpNextActionObserver()
        setUpErrorObservers()
    }
    
    func setUpNextActionObserver(){
        PaymentServicesViewModel.sharedViewModel.validateCardPayment.subscribe(onNext: { response in
            let contentVC = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "PaymentStatusPopupViewController") as! PaymentStatusPopupViewController
            contentVC.cardPaymentResponse = response
            DispatchQueue.main.async {
                let popup = PopupDialog(viewController: contentVC, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false)
                self.present(popup, animated: true, completion: nil)
            }
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

extension NSObject {
    
    var widthPercent: CGFloat {
        return UIScreen.main.bounds.width/100
    }
    
    var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}

