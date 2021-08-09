import UIKit
import MaterialComponents
import RxSwift
class USSDSelectBankViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var bankPicker:UIPickerView!
    var ussdBankPicker:UIPickerView!
    var selectedUSSDBank:USSDBanks?
    var amount : String?
    var banks:[Bank]? = [] {
        didSet{
            bankPicker.reloadAllComponents()
        }
    }
    var selectedBankCode:String?
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(otherBanksTextField)
        view.addSubview(PayButton)
        setupConstraints()
        setUpObservers()
        configureUssdBankView()
    }
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Please select your bank"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont(name: "Avenir", size: CGFloat(15))
        return label
    }()
    
    
    let arrowButtons: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "rave_down_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
        button.tintColor = UIColor(hex: "#647482")
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var otherBanksTextField: MDCOutlinedTextField = {
        let text = MDCOutlinedTextField()
        text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        text.label.text = "Select a Bank"
        text.setFloatingLabelColor(.black, for: .normal)
        text.setFloatingLabelColor(.black, for: .editing)
        text.tintColor = .blue
        text.setNormalLabelColor(.lightGray, for: .normal)
        text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        text.setTextColor(.black, for: .editing)
        text.setTextColor(.black, for: .normal)
        text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
        text.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        redView.addSubview(arrowButtons)
        text.rightView = redView
        text.rightViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    lazy var PayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = KlashaConstants.klashaPink
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.heightAnchor.constraint(equalToConstant: 57).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var anotherPaymentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose another payment method", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant:80),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-20),
            titleLabel.heightAnchor.constraint(equalToConstant: 55),
            
            otherBanksTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            otherBanksTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            otherBanksTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            otherBanksTextField.heightAnchor.constraint(equalToConstant: 57),
            
            PayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            PayButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            PayButton.topAnchor.constraint(equalTo: otherBanksTextField.bottomAnchor, constant: 35),
            PayButton.heightAnchor.constraint(equalToConstant: 57),
        ])
    }
}

extension USSDSelectBankViewController{
    func configureUssdBankView(){
        ussdBankPicker = UIPickerView()
        ussdBankPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
        ussdBankPicker.delegate = self
        ussdBankPicker.dataSource = self
        ussdBankPicker.tag = 13
        self.otherBanksTextField.delegate = self
        self.otherBanksTextField.inputView = ussdBankPicker
        
        self.otherBanksTextField.watchText(validationType: ValidatorType.requiredField(field: "select a Bank"), disposeBag: disposableBag)
        
        PayButton.setTitle("PAY \(self.amount?.toCountryCurrency(code: KlashaConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        
        self.PayButton.rx.tap.subscribe(onNext: {
            
            let bankValid = self.otherBanksTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "select a Bank"))
            self.otherBanksTextField.resignFirstResponder()
            
            if(bankValid ){
                BankViewModel.sharedViewModel
                    .ussd(amount: self.amount.orEmpty(), ussdBank: self.selectedUSSDBank)
            }
        }).disposed(by: disposableBag)
    }
}

extension USSDSelectBankViewController{
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let ussdBanks = getUssdBanks()
        let francophoneCountries = getFrancophoneCountries(countryCode: KlashaConfig.sharedConfig().currencyCode)
//        print("Current PickerView Tag \(pickerView.tag)")
        if pickerView.tag == 12 {
//            print("Country Code logic")
            if let count = self.banks?.count{
                return count
            }else{
                return 0
            }
        }else if  pickerView.tag == 13{
            return ussdBanks.count
        }else if  pickerView.tag == 15{
            return francophoneCountries.count
        }else if  pickerView.tag == 17{
            return KlashaConstants.zambianNetworks.count
        }
        else{
            return KlashaConstants.ghsMobileNetworks.count
        }
    }
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let ussdBanks = getUssdBanks()
        let francophoneCountries = getFrancophoneCountries(countryCode: KlashaConfig.sharedConfig().currencyCode)
        if pickerView.tag == 12 {
            //
            return self.banks?[row].name
        }else if pickerView.tag == 13 {
            return ussdBanks[row].bankName
        }
        else if pickerView.tag == 15 {
            return francophoneCountries[row].countryName
        }
        else  if pickerView.tag == 17 {
            return  KlashaConstants.zambianNetworks[row]
        }
        else{
            return KlashaConstants.ghsMobileNetworks[row].0
        }
        
    }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let ussdBanks = getUssdBanks()
        let francophoneCountries = getFrancophoneCountries(countryCode: KlashaConfig.sharedConfig().currencyCode)
        if pickerView.tag == 12 {
            self.selectedBankCode = self.banks?[row].bankCode
//            self.selectBankAccountView.otherBanksTextField.text = self.banks?[row].name
//            self.selectBankAccountView.otherBanksTextField.sendActions(for: .editingChanged)
        } else if pickerView.tag == 13 {
            self.selectedUSSDBank = ussdBanks[row]
            self.selectedBankCode = ussdBanks[row].bankCode
            self.otherBanksTextField.text = ussdBanks[row].bankName
            self.otherBanksTextField.sendActions(for: .editingChanged)
        }else if pickerView.tag == 15 {
//            self.selectedFrancophoneCountry = francophoneCountries[row]
//            self.selectedFrancophoneCountryCode = francophoneCountries[row].countryCode
//            self.mobileMoneyFRContentContainer.mobileMoneyFRCountry.text = francophoneCountries[row].countryName
//            self.mobileMoneyFRContentContainer.mobileMoneyFRCountry.sendActions(for: .editingChanged)
            
        }
        else if pickerView.tag == 17 {
//            self.mobileMoneyZMContentContainer.mobileMoneyChooseNetwork.text = KlashaConstants.zambianNetworks[row]
//            flutterwaveMoneyZM.network = KlashaConstants.zambianNetworks[row]
        }
        else{
//            self.mobileMoneyContentView.mobileMoneyChooseNetwork.text = KlashaConstants.ghsMobileNetworks[row].0
//            self.mobileMoneyContentView.mobileMoneyTitle.text = KlashaConstants.ghsMobileNetworks[row].1
//
//            if (KlashaConstants.ghsMobileNetworks[row].0 == "VODAFONE"){
//                mobileMoneyContentView.mobileMoneyVoucher.isHidden = false
//            }else{
//                mobileMoneyContentView.mobileMoneyVoucher.isHidden = true
//            }
//            flutterwaveMobileMoney.selectedMobileNetwork = KlashaConstants.ghsMobileNetworks[row].0
        }
    }
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}


extension USSDSelectBankViewController {
    
    func setUpObservers(){
        setUpNextActionObservers()
        setUpErrorObservers()
    }
    
    func setUpNextActionObservers(){
        BankViewModel.sharedViewModel.ussdResponse.subscribe(onNext: { [self] response in
            let controller = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "USSDConfirmViewController") as! USSDConfirmViewController
           // KlashaCardClient.sharedCardClient.transactionReference = response.txRef
            controller.amount = amount
            self.navigationController?.pushViewController(controller, animated: true)
        } ).disposed(by: disposableBag)
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





