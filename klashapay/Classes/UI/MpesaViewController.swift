import UIKit
import MaterialComponents

class MpesaViewController: BaseViewController {
    
    var amount: String?

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your phone number to\nbegin payment."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(17))
        return label
    }()
    
    lazy var mpesaPhoneNumber: MDCOutlinedTextField = {
        let text = MDCOutlinedTextField()
        text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        text.label.text = "Phone number"
        text.setFloatingLabelColor(.black, for: .normal)
        text.setFloatingLabelColor(.black, for: .editing)
        text.tintColor = .lightGray
        text.font = Fonts.podFont(name: "Regular.ttf", size: CGFloat(16))
        text.setTextColor(.black, for: .editing)
        text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        text.setTextColor(.black, for: .normal)
        text.setNormalLabelColor(.lightGray, for: .normal)
        text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
        text.setOutlineColor(KlashaConstants.klashaPink, for: .editing)
        text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        text.leftViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        text.keyboardType = .numberPad
        return text
    }()
    
    lazy var mpesaPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
         button.titleLabel?.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(15))
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = KlashaConstants.klashaPink
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
    
    override func viewDidLoad() {
    super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(mpesaPhoneNumber)
        view.addSubview(mpesaPayButton)
        view.addSubview(payWithKlashaStack)
        payWithKlashaStack.addArrangedSubview(payWithLabel)
        payWithKlashaStack.addArrangedSubview(klashaLogo)
        view.addSubview(amountEmailStack)
        amountEmailStack.addArrangedSubview(emailLabel)
        amountEmailStack.addArrangedSubview(amountLabel)
        setupConstraints()
        configureMpesaView()
        setUpObservers()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            payWithKlashaStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:20),
            payWithKlashaStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-20),
            payWithKlashaStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            
            amountEmailStack.topAnchor.constraint(equalTo: payWithKlashaStack.bottomAnchor, constant:20),
            amountEmailStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-20),
            amountEmailStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            titleLabel.topAnchor.constraint(equalTo: amountEmailStack.bottomAnchor, constant:20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-20),
            titleLabel.heightAnchor.constraint(equalToConstant: 55),
            
            mpesaPhoneNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mpesaPhoneNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mpesaPhoneNumber.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            mpesaPhoneNumber.heightAnchor.constraint(equalToConstant: 57),
            
            mpesaPayButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mpesaPayButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mpesaPayButton.topAnchor.constraint(equalTo: mpesaPhoneNumber.bottomAnchor, constant: 26),
            mpesaPayButton.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
    
    func configureMpesaView(){
        KlashaMpesaClient.sharedMpesaClient.transactionReference = KlashaConfig.sharedConfig().transcationRef

        mpesaPayButton.layer.cornerRadius = 5
        mpesaPayButton.setTitle("Pay \(self.amount?.toCountryCurrency(code: KlashaConfig.sharedConfig().currencyCode) ?? "")", for: .normal)
        mpesaPayButton.addTarget(self, action: #selector(mpesaPayButtonTapped), for: .touchUpInside)

        KlashaMpesaClient.sharedMpesaClient.amount = self.amount
        KlashaMpesaClient.sharedMpesaClient.email = KlashaConfig.sharedConfig().email

        self.mpesaPhoneNumber.watchText(validationType: ValidatorType.requiredField(field: "phone number"), disposeBag: disposableBag)
    }
    
    //MARK: MPESA Payment
    @objc func mpesaPayButtonTapped(){
        self.mpesaPayAction()
    }
    
    func mpesaPayAction(){
        self.view.endEditing(true)
        KlashaMpesaClient.sharedMpesaClient.phoneNumber = mpesaPhoneNumber.text.orEmpty().components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        let phoneValid = self.mpesaPhoneNumber.validateAndShowError(validationType: ValidatorType.requiredField(field: "phone number"))

        if(phoneValid ){
            KlashaMpesaClient.sharedMpesaClient.chargeMpesa()
        }
    }
}

extension MpesaViewController {
    func setUpObservers(){
        setUpLoading()
        setUpResponseObserver()
        setUpErrorObservers()
    }
    
    func setUpLoading(){
        setUpLoadingObservers(baseViewModel: MobileMoneyViewModel.sharedViewModel)
    }
 
    
    func setUpResponseObserver() {
        MobileMoneyViewModel.sharedViewModel.mpesaMoneyResponse.subscribe(onNext: {
            response in
            showSnackBarWithMessage(msg: "\(response.message ?? "")")
        }).disposed(by: disposableBag)
    }
    
    func setUpErrorObservers(){
        MobileMoneyViewModel.sharedViewModel.error.subscribe(onNext: { errorMessage in
            DispatchQueue.main.async {
                KlashaCardClient.sharedCardClient.error!(errorMessage,nil)
            }
        }).disposed(by: disposableBag)
    }
}

