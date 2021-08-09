import klashapay
import UIKit

class ViewController: UIViewController, KlashaPayProtocol {
    
    func fundWithKlashaWalletTransactionSuccessful(txRef: String?, responseData: KlashaWalletMakePaymentResponse?) {
        print("Fund with Klasha Wallet Successful")
    }
    
    func fundWithKlashaWalletTransactionFailed(txRef: String?, responseData: KlashaWalletMakePaymentResponse?) {
        print( "Funding with Klasha Wallet Failed to return data with FlwRef \(txRef.orEmpty())")
    }
    
    func onDismiss() {
        print("View controller was dimissed ")
    }
    
    
    func tranasctionSuccessful(txnRef: String?, responseData: ValidateCardPaymentResponse?) {
        print("DATA Returned \(responseData?.txRef ?? "Failed to return data")")
    }
    
    func tranasctionFailed(flwRef: String?, responseData: ValidateCardPaymentResponse?) {
        print( "Failed to return data with FlwRef \(flwRef.orEmpty())")
    }
    
    let flutterLabel = UILabel()
    let exampleLabel = UILabel()
    let underLineView = UIView()
    let launchButton = UIButton(type: .system)
    
    lazy var isStagingLabel: UILabel = {
        let label = UILabel()
        label.text = "Staging?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(hex: "#FDE5E3")
        let placeholderText = NSAttributedString(string: "e.g 1000",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeholderText
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        return textField
    }()
    
    lazy var currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Currency"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var currencyCodeTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .alphabet
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(hex: "#FDE5E3")
        let placeholderText = NSAttributedString(string: "e.g NGN",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeholderText
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        return textField
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .alphabet
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor(hex: "#FDE5E3")
        textField.keyboardType = .emailAddress
        let placeholderText = NSAttributedString(string: "e.g dan@gmail.com",
                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeholderText
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = UIColor.black
        return textField
    }()
    
    lazy var isStagingSwitch : UISwitch = {
        let isStagingSwtch = UISwitch()
        isStagingSwtch.onTintColor = UIColor(hex: "#e75241")
        return isStagingSwtch
    }()
    
    lazy var formStack : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 20
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var isStagingStack : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var amountStack : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var currencyCodeStack : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var emailStack : UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    
    @objc func showExample(){
        
        if currencyCodeTextField.isEmpty || amountTextField.isEmpty || emailTextField.isEmpty{
            return
        }
        
        let config = KlashaConfig.sharedConfig()
        
        config.currencyCode = currencyCodeTextField.text! // This is the specified currency to charge in.
        config.email = emailTextField.text! // This is the email address of the customer
        config.isStaging = isStagingSwitch.isOn // Toggle this for staging and live environment
        config.phoneNumber = "07067783334" //Phone number
        config.transcationRef = "trial-rewt-nfue-vbgf" // This is a unique reference, unique to the particular transaction being carried out. It is generated when it is not provided by the merchant for every transaction.
        config.firstName = "Yemi" // This is the customers first name.
        config.lastName = "Desola" //This is the customers last name.
        config.meta = [["metaname":"sdk", "metavalue":"ios"]] //This is used to include additional payment information
        config.narration = "accepting payments everywhere"
        config.publicKey = "FLWPUBK_TEST-dcc5e2d5d6be710a6ce032c82402ad88-X" //Public key
        config.encryptionKey = "FLWSECK_TEST4d4d7784847f" //Encryption key
        guard let controller = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "KlashaPayLandingViewController") as? KlashaPayLandingViewController else {
            fatalError("Unable to Instantiate KlashaPayLandingViewController")
        }
       let nav = UINavigationController(rootViewController: controller)
        controller.amount = amountTextField.text! // This is the amount to be charged.
        controller.delegate = self
        nav.navigationBar.backgroundColor = .clear
       // nav.modalPresentationStyle = .overFullScreen
        UINavigationBar.appearance().barTintColor = UIColor(hex: "#E75241")
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
        self.present(nav, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
       
        setUpConstraintsAndProperties()
        showExample()
    }
    
    override func viewDidLayoutSubviews() {
        amountTextField.underlined()
        currencyCodeTextField.underlined()
        emailTextField.underlined()
    }
    
}

extension ViewController {
    
    func setUpConstraintsAndProperties(){
        
        addAllViews()
        setupFlutterLabel()
        setupExampleLabel()
        setupUnderLineView()
        setupLaunchButton()
        view.backgroundColor = UIColor(hex: "#fcede9")
        
    }
    func addAllViews(){
        view.addSubview(flutterLabel)
        view.addSubview(exampleLabel)
        view.addSubview(underLineView)
        view.addSubview(launchButton)
        view.addSubview(formStack)
        view.addSubview(isStagingStack)
        view.addSubview(amountStack)
        view.addSubview(emailStack)
        formStack.addArrangedSubview(isStagingStack)
        formStack.addArrangedSubview(amountStack)
        formStack.addArrangedSubview(currencyCodeStack)
        formStack.addArrangedSubview(emailStack)
        isStagingStack.addArrangedSubview(isStagingLabel)
        isStagingStack.addArrangedSubview(isStagingSwitch)
        amountStack.addArrangedSubview(amountLabel)
        amountStack.addArrangedSubview(amountTextField)
        currencyCodeStack.addArrangedSubview(currencyCodeLabel)
        currencyCodeStack.addArrangedSubview(currencyCodeTextField)
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailTextField)
        
        NSLayoutConstraint.activate([
            flutterLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            flutterLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
             flutterLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            exampleLabel.topAnchor.constraint(equalTo: flutterLabel.bottomAnchor, constant: 5),
            exampleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            underLineView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            underLineView.topAnchor.constraint(equalTo: exampleLabel.bottomAnchor, constant: 8),
            underLineView.heightAnchor.constraint(equalToConstant: 1),
            underLineView.widthAnchor.constraint(equalToConstant: 158),
            
            formStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            formStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            formStack.topAnchor.constraint(equalTo: underLineView.bottomAnchor, constant: 30),
        
            
            launchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            launchButton.heightAnchor.constraint(equalToConstant: 50),
            launchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            launchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
  
        ])
    }
    
    
    func setupFlutterLabel(){
        
        
        let attributedTitle = NSMutableAttributedString(string: "Welcome to ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold) as Any, NSAttributedString.Key.foregroundColor: UIColor(hex: "#6E6B67")])
        
        attributedTitle.append(NSAttributedString(string: "KLASHA SDK", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 23, weight: .semibold) as Any, NSAttributedString.Key.foregroundColor: UIColor(hex: "#050300")]))
        
        flutterLabel.attributedText = attributedTitle
        
        flutterLabel.numberOfLines = 0
       
        flutterLabel.translatesAutoresizingMaskIntoConstraints = false
        flutterLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setupExampleLabel(){
        exampleLabel.text = "V1 Example"
        exampleLabel.numberOfLines = 0
        exampleLabel.textColor = UIColor(hex: "#6E6B67")
        exampleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        exampleLabel.translatesAutoresizingMaskIntoConstraints = false
        exampleLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setupUnderLineView(){
        underLineView.backgroundColor = UIColor.systemPink
        underLineView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupLaunchButton(){
        launchButton.setTitle("LAUNCH KLASHAPAY", for: .normal)
        launchButton.setTitleColor(.white, for: .normal)
        launchButton.backgroundColor = UIColor(hex: "#E75241")
        launchButton.layer.cornerRadius = 4
        launchButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        launchButton.heightAnchor.constraint(equalToConstant: 57).isActive = true
        launchButton.translatesAutoresizingMaskIntoConstraints = false
        launchButton.addTarget(self, action: #selector(showExample), for: .touchUpInside)
 
    }
    
    static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
            fatalError("Couldn't find font \(fontName)")
        }

        guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
            fatalError("Couldn't load data from the font \(fontName)")
        }

        guard let font = CGFont(fontDataProvider) else {
            fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterGraphicsFont(font, &error)
        guard success else {
            print("Error registering font: maybe it was already registered.")
            return false
        }

        return true
    }
}




