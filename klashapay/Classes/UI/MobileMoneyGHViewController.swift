import UIKit
import MaterialComponents

class MobileMoneyGHViewController: BaseViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, KlashaPayWebProtocol {

    public weak var delegate: KlashaPayProtocol?
    
    func tranasctionSuccessful(flwRef: String, responseData: FlutterwaveDataResponse?) {
        self.dismiss(animated: true) {
           // self.delegate?.tranasctionSuccessful(txnRef: flwRef, responseData: )
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return KlashaConstants.ghsMobileNetworks.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return KlashaConstants.ghsMobileNetworks[row].0
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
            self.mobileMoneyChooseNetwork.text = KlashaConstants.ghsMobileNetworks[row].0
           // self.mobileMoneyTitle.text = KlashaConstants.ghsMobileNetworks[row].1
            
//            if (KlashaConstants.ghsMobileNetworks[row].0 == "VODAFONE"){
//                mobileMoneyVoucher.isHidden = false
//            }else{
//                mobileMoneyVoucher.isHidden = true
//            }
        ghanaMobileMoneyClient.selectedMobileNetwork = KlashaConstants.ghsMobileNetworks[row].0
        
    }
    
    var ghsMobileMoneyPicker: UIPickerView = UIPickerView()
    let ghanaMobileMoneyClient = KlashaMobileMoneyClient()
    
    var amount: String?
    var selectedNetwork:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        //view.addSubview(mobileMoneyTitle)
        view.addSubview(stackView)
        stackView.addArrangedSubview(mobileMoneyChooseNetwork)
      //  stackView.addArrangedSubview(mobileMoneyVoucher)
        stackView.addArrangedSubview(mobileMoneyPhoneNumber)
        stackView.addArrangedSubview(mobileMoneyPay)
        view.addSubview(payWithKlashaStack)
        payWithKlashaStack.addArrangedSubview(payWithLabel)
        payWithKlashaStack.addArrangedSubview(klashaLogo)
        view.addSubview(amountEmailStack)
        amountEmailStack.addArrangedSubview(emailLabel)
        amountEmailStack.addArrangedSubview(amountLabel)
        setupConstraints()
        setUpObservers()
        configureMobileMoneyGhana()
    }
    
//    lazy var mobileMoneyTitle: UILabel = {
//        let label = UILabel()
//        label.text = "Please Dial *170#, click on Pay and wait for\ninstructions on the next screen"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
//        return label
//    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = KlashaConfig.sharedConfig().email
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(17))
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.amount?.toCountryCurrency(code: KlashaConfig.sharedConfig().currencyCode) ?? "")"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(17))
        return label
    }()
    
    lazy var payWithLabel: UILabel = {
        let label = UILabel()
        label.text = "PAY WITH"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.font = Fonts.podFont(name: "Bolds.ttf", size: CGFloat(20))
        return label
    }()
    
    
    lazy var klashaLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "klasha"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    lazy var payWithKlashaStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    lazy var amountEmailStack: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    let arrowButton: UIButton = {
           let button = UIButton(type: .custom)
           button.setImage(UIImage(named: "rave_down_arrow",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
           button.tintColor = UIColor(hex: "#647482")
           button.widthAnchor.constraint(equalToConstant: 20).isActive = true
           button.heightAnchor.constraint(equalToConstant: 20).isActive = true
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
    
    lazy var mobileMoneyChooseNetwork: MDCOutlinedTextField = {
        let text = MDCOutlinedTextField()
        text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        text.label.text = "Choose Network"
        text.setFloatingLabelColor(.black, for: .normal)
        text.setFloatingLabelColor(.black, for: .editing)
        text.tintColor = .lightGray
        text.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        text.setTextColor(.black, for: .editing)
        text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        text.setTextColor(.black, for: .normal)
        text.setNormalLabelColor(.lightGray, for: .normal)
        text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
        text.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
        text.rightView = arrowButton
        text.rightViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        
        return text
    }()
    
    lazy var mobileMoneyPhoneNumber: MDCOutlinedTextField = {
        let text = MDCOutlinedTextField()
        text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        text.label.text = "Phone Number"
        text.setFloatingLabelColor(.black, for: .normal)
        text.setFloatingLabelColor(.black, for: .editing)
        text.tintColor = .lightGray
        text.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        text.setTextColor(.black, for: .editing)
        text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        text.setTextColor(.black, for: .normal)
        text.setNormalLabelColor(.lightGray, for: .normal)
        text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
        text.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        text.keyboardType = .numberPad
        return text
    }()

    lazy var mobileMoneyPay: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = KlashaConstants.klashaPink
        button.layer.cornerRadius = 4
        button.heightAnchor.constraint(equalToConstant: 57).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 14
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            payWithKlashaStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:20),
            payWithKlashaStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-20),
            payWithKlashaStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            
            amountEmailStack.topAnchor.constraint(equalTo: payWithKlashaStack.bottomAnchor, constant:20),
            amountEmailStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-20),
            amountEmailStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
//            mobileMoneyTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
//            mobileMoneyTitle.topAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.topAnchor, constant:20),
//            mobileMoneyTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-20),
//            mobileMoneyTitle.heightAnchor.constraint(equalToConstant: 55),
//
            stackView.topAnchor.constraint(equalTo:  amountEmailStack.bottomAnchor, constant:20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-20),
            
            
        ])
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func configureMobileMoneyGhana(){
        ghsMobileMoneyPicker.autoresizingMask  = [.flexibleWidth , .flexibleHeight]
        ghsMobileMoneyPicker.delegate = self
        ghsMobileMoneyPicker.dataSource = self
        ghsMobileMoneyPicker.tag = 20
        self.mobileMoneyChooseNetwork.delegate = self
        
        self.mobileMoneyChooseNetwork.inputView = ghsMobileMoneyPicker
        mobileMoneyChooseNetwork.layer.cornerRadius = 5
        
        mobileMoneyPhoneNumber.layer.cornerRadius = 5
        
      //  mobileMoneyVoucher.layer.cornerRadius = 5
        
        mobileMoneyPay.layer.cornerRadius = 5
        mobileMoneyPay.setTitle("Pay \(self.amount?.toCountryCurrency(code: KlashaConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mobileMoneyPay.addTarget(self, action: #selector(mobileMoneyPayAction), for: .touchUpInside)
        
        self.mobileMoneyPhoneNumber.watchText(validationType: ValidatorType.requiredField(field: "phone number"), disposeBag: disposableBag)
        self.mobileMoneyChooseNetwork.watchText(validationType: ValidatorType.requiredField(field: "choose network"), disposeBag: disposableBag)
//        self.mobileMoneyVoucher.watchText(validationType: ValidatorType.requiredField(field: "voucher"), disposeBag: disposableBag)
        
    }
    
    @objc func mobileMoneyPayAction(){
        self.view.endEditing(true)
        ghanaMobileMoneyClient.network = mobileMoneyChooseNetwork.text
    //    ghanaMobileMoneyClient.voucher = mobileMoneyVoucher.text
        ghanaMobileMoneyClient.phoneNumber = mobileMoneyPhoneNumber.text.orEmpty().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        // raveMobileMoney.chargeMobileMoney()
        
        let phoneValid = self.mobileMoneyPhoneNumber.validateAndShowError(validationType: ValidatorType.requiredField(field: "phone number"))
        let networkValid = self.mobileMoneyChooseNetwork.validateAndShowError(validationType: ValidatorType.requiredField(field: "choose network"))
        
       // let voucherValid = self.mobileMoneyVoucher.validateAndShowError(validationType: ValidatorType.requiredField(field: "voucher"))
        
       // let validateVoucher = voucherValid && phoneValid  && networkValid
        let phoneNetworkValid = phoneValid && networkValid
        
        selectedNetwork = mobileMoneyChooseNetwork.text
//        switch selectedNetwork {
//        case "VODAFONE":
//            if(!validateVoucher){
//                return
//            }
//        default:
//            if(!phoneNetworkValid){
//                return
//            }
//        }
        MobileMoneyViewModel.sharedViewModel.ghanaMoney(amount: self.amount ?? "", voucher: "", network: selectedNetwork ?? "", phoneNumber: ghanaMobileMoneyClient.phoneNumber ?? "")
    }
    
}

extension MobileMoneyGHViewController {
    func setUpObservers(){
        setUpLoading()
        setUpResponseObserver()
        setUpNextActionObservers()
        setUpErrorObservers()
    }
    
    func setUpLoading(){
        setUpLoadingObservers(baseViewModel: MobileMoneyViewModel.sharedViewModel)
    }
    
    func setUpNextActionObservers(){
        setUpMoveToWebView(baseViewModel: MobileMoneyViewModel.sharedViewModel, action: {url,ref in
            self.showWebView(url: url,ref:ref)
        })
    }
    
    func setUpResponseObserver() {
        MobileMoneyViewModel.sharedViewModel.ghanaMoneyResponse.subscribe(onNext: {
            response in
            showSnackBarWithMessage(msg: "\(response.message ?? ""), \(response.data!.processorResponse ?? ""))")
        }).disposed(by: disposableBag)
    }
    
    func setUpErrorObservers(){
        MobileMoneyViewModel.sharedViewModel.error.subscribe(onNext: { errorMessage in
            DispatchQueue.main.async {
                KlashaCardClient.sharedCardClient.error!(errorMessage,nil)
            }
        }).disposed(by: disposableBag)
    }
    
    func showWebView(url: String?,ref:String?){
        let controller = KlashaPayWebViewController()
        controller.flwRef = ref
        controller.url = url
        controller.delegate = self
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
