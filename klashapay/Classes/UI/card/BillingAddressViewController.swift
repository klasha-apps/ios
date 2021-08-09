import UIKit
import MaterialComponents

class BillingAddressViewController: BaseViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(klashaLogo)
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(billingContinueButton)
        stackView.addArrangedSubview(billingAddressTextField)
        stackView.addArrangedSubview(firstStackView)
        stackView.addArrangedSubview(secondStackView)

        firstStackView.addArrangedSubview(cityTextField)
        firstStackView.addArrangedSubview(stateTextField)

        secondStackView.addArrangedSubview(zipCodeTextField)
        secondStackView.addArrangedSubview(countryTextField)
        
        setupConstraints()
    }
    
    

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your billing address"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir", size: 17)
        return label
    }()
    
    lazy var billingAddressTextField: MDCOutlinedTextField = {
           let text = MDCOutlinedTextField()
           text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
           text.label.text = "Address"
           text.setFloatingLabelColor(.black, for: .normal)
           text.setFloatingLabelColor(.black, for: .editing)
           text.tintColor = .lightGray
           text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
           text.setNormalLabelColor(.lightGray, for: .normal)
           text.setTextColor(.black, for: .editing)
           text.setTextColor(.black, for: .normal)
           text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
           text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
           text.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
           text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
           text.leftViewMode = .always
           text.translatesAutoresizingMaskIntoConstraints = false
           text.heightAnchor.constraint(equalToConstant: 57).isActive = true
           return text
       }()
    
   lazy var cityTextField: MDCOutlinedTextField = {
       let text = MDCOutlinedTextField()
       text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
       text.label.text = "City"
       text.setFloatingLabelColor(.black, for: .normal)
       text.setFloatingLabelColor(.black, for: .editing)
       text.setNormalLabelColor(.lightGray, for: .normal)
       text.tintColor = .lightGray
       text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
       text.setTextColor(.black, for: .editing)
       text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
       text.setTextColor(.black, for: .normal)
       text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
       text.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
       text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
       text.leftViewMode = .always
       text.translatesAutoresizingMaskIntoConstraints = false
       text.heightAnchor.constraint(equalToConstant: 57).isActive = true
       return text
   }()
    
    lazy var stateTextField: MDCOutlinedTextField = {
          let text = MDCOutlinedTextField()
          text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
          text.label.text = "State"
          text.setFloatingLabelColor(.black, for: .normal)
          text.setFloatingLabelColor(.black, for: .editing)
          text.setNormalLabelColor(.lightGray, for: .normal)
          text.tintColor = .lightGray
          text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
          text.setTextColor(.black, for: .editing)
          text.setTextColor(.black, for: .normal)
          text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
          text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
          text.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
          text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
          text.leftViewMode = .always
          text.translatesAutoresizingMaskIntoConstraints = false
          text.heightAnchor.constraint(equalToConstant: 57).isActive = true
          return text
      }()
   
    lazy var zipCodeTextField: MDCOutlinedTextField = {
             let text = MDCOutlinedTextField()
             text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
             text.label.text = "Zip code / PostCode"
             text.setFloatingLabelColor(.black, for: .normal)
             text.setFloatingLabelColor(.black, for: .editing)
             text.setNormalLabelColor(.lightGray, for: .normal)
             text.tintColor = .lightGray
             text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
             text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
             text.setTextColor(.black, for: .editing)
             text.setTextColor(.black, for: .normal)
             text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
             text.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
             text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
             text.leftViewMode = .always
             text.translatesAutoresizingMaskIntoConstraints = false
             text.heightAnchor.constraint(equalToConstant: 57).isActive = true
             return text
         }()
    
    lazy var countryTextField: MDCOutlinedTextField = {
                let text = MDCOutlinedTextField()
                text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
                text.label.text = "Country"
                text.setFloatingLabelColor(.black, for: .normal)
                text.setFloatingLabelColor(.black, for: .editing)
                text.setNormalLabelColor(.lightGray, for: .normal)
                text.tintColor = .lightGray
                text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
                text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
                text.setTextColor(.black, for: .editing)
                text.setTextColor(.black, for: .normal)
                text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
                text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
                text.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
                text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
                text.leftViewMode = .always
                text.translatesAutoresizingMaskIntoConstraints = false
                text.heightAnchor.constraint(equalToConstant: 57).isActive = true
                return text
            }()
    
    lazy var klashaLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "klasha"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    lazy var billingContinueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CONTINUE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = KlashaConstants.klashaPink
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 15
        stack.axis = .vertical
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var firstStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var secondStackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            klashaLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:35),
            klashaLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-20),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20),
            titleLabel.topAnchor.constraint(equalTo: klashaLogo.bottomAnchor, constant:35),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-20),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 42),
            
            billingContinueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            billingContinueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            billingContinueButton.heightAnchor.constraint(equalToConstant: 57),
            billingContinueButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 42),
        ])
    }
}

extension BillingAddressViewController{
    func configureAndValidateFields(){
        self.zipCodeTextField.watchText(validationType: ValidatorType.requiredField(field: "zip"), disposeBag: disposableBag)
        self.billingAddressTextField.watchText(validationType: ValidatorType.requiredField(field: "billing address"), disposeBag: disposableBag)
        self.stateTextField.watchText(validationType: ValidatorType.requiredField(field: "state"), disposeBag: disposableBag)
        self.cityTextField.watchText(validationType: ValidatorType.requiredField(field: "city"), disposeBag: disposableBag)
        self.countryTextField.watchText(validationType: ValidatorType.requiredField(field: "country"), disposeBag: disposableBag)
        
        billingAddressTextField.delegate = self
        
        stateTextField.delegate = self
        
        cityTextField.delegate = self
        countryTextField.delegate = self
        
        zipCodeTextField.delegate = self
        billingContinueButton.addTarget(self, action: #selector(billAddressButtonTapped), for: .touchUpInside)
    }
    
    @objc func billAddressButtonTapped(){
        
        let zipValid = self.zipCodeTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "zip"))
        let cityValid = self.cityTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "city"))
        let addressValid = self.billingAddressTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "address"))
        let countyValid = self.countryTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "country"))
        let stateValid = self.stateTextField.validateAndShowError(validationType: ValidatorType.requiredField(field: "state"))
        
        if (zipValid && cityValid && addressValid && countyValid && stateValid ){
            self.billAddressAction()
        }
    }
    
    func billAddressAction(){
        self.view.endEditing(true)
        guard let zip = self.zipCodeTextField.text, let city = self.cityTextField.text,
            let address = self.billingAddressTextField.text, let country = self.countryTextField.text , let state = self.stateTextField.text else {return}
    
//        KlashaCardClient.sharedCardClient.city = city
//        KlashaCardClient.sharedCardClient.address = address
//        KlashaCardClient.sharedCardClient.state = state
//        KlashaCardClient.sharedCardClient.country = country
//        KlashaCardClient.sharedCardClient.zipCode = zip
        KlashaCardClient.sharedCardClient.chargeCard()
    }
}
