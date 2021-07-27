//
//  KlashaWalletLoginViewController.swift
//  klashapay
//
//  Created by Adegoke Ayomikun on 09/07/2021.
//

import UIKit
import MaterialComponents

class KlashaWalletLoginViewController: BaseViewController {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    @IBOutlet weak var emailTextField: MDCOutlinedTextField!
    
    var amount: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomFont()
        styleTextFields()
        setUpObservers()
        setCustomFont()
        // Do any additional setup after loading the view.
    }
    
    func setCustomFont(){
        emailTextField.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        passwordTextField.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
    }

    @IBAction func onLoginButtonClicked(_ sender: Any) {
        let emailValidator = ValidatorType.email
        let passwordValidator = ValidatorType.password
        let emailValid = emailTextField.validateAndShowError(validationType: emailValidator)
        let passwordValid = passwordTextField.validateAndShowError(validationType: passwordValidator)
        if emailValid && passwordValid{
            klashaWalletLogin()
        }
    }
    
    func klashaWalletLogin() {
        self.view.endEditing(true)
        KlashaWalletClient.sharedWalletClient.login(username: emailTextField.text, password: passwordTextField.text)
    }
    
    
    func styleTextFields(){
        emailTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        emailTextField.label.text = "Email address"
        emailTextField.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        emailTextField.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        emailTextField.setFloatingLabelColor(.black, for: .normal)
        emailTextField.setFloatingLabelColor(.black, for: .editing)
        emailTextField.tintColor = .lightGray
        emailTextField.setNormalLabelColor(.lightGray, for: .normal)
        emailTextField.setTextColor(.black, for: .editing)
        emailTextField.setTextColor(.black, for: .normal)
        emailTextField.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.4), for: .normal)
        emailTextField.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        passwordTextField.label.text = "Password"
        passwordTextField.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        passwordTextField.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        passwordTextField.setFloatingLabelColor(.black, for: .normal)
        passwordTextField.setFloatingLabelColor(.black, for: .editing)
        passwordTextField.tintColor = .lightGray
        passwordTextField.setNormalLabelColor(.lightGray, for: .normal)
        passwordTextField.setTextColor(.black, for: .editing)
        passwordTextField.setTextColor(.black, for: .normal)
        passwordTextField.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.4), for: .normal)
        passwordTextField.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.keyboardType = .default
        passwordTextField.textContentType = .password
    }
}

extension KlashaWalletLoginViewController {
    
    func setUpObservers(){
        setUpLoading()
        setUpNextActionObservers()
        setUpErrorObservers()
    }
    
    func setUpNextActionObservers(){
        PaymentServicesViewModel.sharedViewModel.klashaWalletLoginResponse.subscribe(onNext: { [self] response in
            let controller = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "KlashaWalletPayViewController") as! KlashaWalletPayViewController
            controller.amount = amount
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
                KlashaWalletClient.sharedWalletClient.error!(errorMessage,nil)
            }
        }).disposed(by: disposableBag)
    }
}
