import UIKit
import MaterialComponents

class MobileMoneyFR: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your phone number and country to begin payment."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
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
    
    lazy var mobileMoneyFRPhone: MDCOutlinedTextField = {
              let text = MDCOutlinedTextField()
              text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
              text.label.text = "Phone number"
              text.setFloatingLabelColor(.black, for: .normal)
              text.setFloatingLabelColor(.black, for: .editing)
              text.tintColor = .lightGray
              text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
              text.setTextColor(.black, for: .editing)
              text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
              text.setTextColor(.black, for: .normal)
              text.setNormalLabelColor(.lightGray, for: .normal)
              text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
              text.setOutlineColor(UIColor(hex: "#F5A623").withAlphaComponent(0.87), for: .editing)
              text.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
              text.leftViewMode = .always
              text.translatesAutoresizingMaskIntoConstraints = false
              text.keyboardType = .numberPad
              return text
          }()
    
 
    lazy var mobileMoneyFRCountry: MDCOutlinedTextField = {
               let text = MDCOutlinedTextField()
               text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
               text.label.text = "Select country"
               text.setFloatingLabelColor(.black, for: .normal)
               text.setFloatingLabelColor(.black, for: .editing)
               text.tintColor = .lightGray
               text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
               text.setTextColor(.black, for: .editing)
               text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
               text.setTextColor(.black, for: .normal)
               text.setNormalLabelColor(.lightGray, for: .normal)
               text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
               text.setOutlineColor(UIColor(hex: "#F5A623").withAlphaComponent(0.87), for: .editing)
               text.rightView = arrowButtons
               text.rightViewMode = .always
               text.translatesAutoresizingMaskIntoConstraints = false
               text.keyboardType = .numberPad
               return text
           }()
    
    
    
    lazy var mobileMoneyFRPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(mobileMoneyFRPhone)
        addSubview(mobileMoneyFRCountry)
        addSubview(mobileMoneyFRPayButton)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            titleLabel.heightAnchor.constraint(equalToConstant: 55),
            
            mobileMoneyFRPhone.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mobileMoneyFRPhone.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mobileMoneyFRPhone.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            mobileMoneyFRPhone.heightAnchor.constraint(equalToConstant: 57),
            
            mobileMoneyFRCountry.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mobileMoneyFRCountry.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mobileMoneyFRCountry.topAnchor.constraint(equalTo: mobileMoneyFRPhone.bottomAnchor, constant: 25),
            mobileMoneyFRCountry.heightAnchor.constraint(equalToConstant: 57),
            
            mobileMoneyFRPayButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mobileMoneyFRPayButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mobileMoneyFRPayButton.topAnchor.constraint(equalTo: mobileMoneyFRCountry.bottomAnchor, constant: 26),
            mobileMoneyFRPayButton.heightAnchor.constraint(equalToConstant: 50),
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
