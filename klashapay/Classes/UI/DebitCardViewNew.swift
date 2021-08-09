import Foundation
import UIKit
import MaterialComponents

class DebitCardViewNew: UIView {
    
    let cardImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        let images = UIImage(named:  "rave_credit_card",in: Bundle.getResourcesBundle()!, compatibleWith: nil) as UIImage?
//        let images = UIImage(named: "rave_credit_card") as UIImage?
        image.image = images
        image.widthAnchor.constraint(equalToConstant: 25).isActive = true
        image.heightAnchor.constraint(equalToConstant: 25).isActive = true
        return image
    }()
    
    
    let questionButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "rave_question_mark",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
        button.tintColor = UIColor(hex: "#647482")
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleInfo: UILabel = {
        let label = UILabel()
        label.text = "Enter your card information."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    lazy var cardNumberTextField: MDCOutlinedTextField = {
        let text = MDCOutlinedTextField()
        text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        text.label.text = "Card number"
        text.setFloatingLabelColor(.black, for: .normal)
        text.setFloatingLabelColor(.black, for: .editing)
        text.tintColor = .lightGray
        text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        text.setNormalLabelColor(.lightGray, for: .normal)
        text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        text.setTextColor(.black, for: .editing)
        text.setTextColor(.black, for: .normal)
        text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
        text.setOutlineColor(UIColor(hex: "#F5A623").withAlphaComponent(0.87), for: .editing)
        
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 24))
        redView.addSubview(cardImageView)
        text.leftView = redView
        text.leftViewMode = .always
        text.keyboardType = .numberPad
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    lazy var cardExpiry: MDCOutlinedTextField = {
        let text = MDCOutlinedTextField()
        text.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        text.label.text = "Expiry Date"
        text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        text.setFloatingLabelColor(.black, for: .normal)
        text.setFloatingLabelColor(.black, for: .editing)
        text.tintColor = .lightGray
        text.setNormalLabelColor(.lightGray, for: .normal)
        text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        text.setTextColor(.black, for: .editing)
        text.setTextColor(.black, for: .normal)
        text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.17), for: .normal)
        text.setOutlineColor(UIColor(hex: "#F5A623").withAlphaComponent(0.87), for: .editing)
        text.translatesAutoresizingMaskIntoConstraints = false
        text.keyboardType = .numberPad
        return text
    }()
    
    
    lazy var cardCVV: MDCOutlinedTextField = {
        let text = MDCOutlinedTextField()
        text.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        text.label.text = "CVV"
        text.setFloatingLabelColor(.black, for: .normal)
        text.setFloatingLabelColor(.black, for: .editing)
        text.tintColor = .lightGray
        text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        text.setNormalLabelColor(.lightGray, for: .normal)
        text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        text.setTextColor(.black, for: .editing)
        text.setTextColor(.black, for: .normal)
        text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.17), for: .normal)
        text.setOutlineColor(UIColor(hex: "#F5A623").withAlphaComponent(0.87), for: .editing)
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        redView.addSubview(questionButton)
        
        text.rightView =  redView
        text.rightViewMode = .always
        text.keyboardType = .numberPad
        text.isSecureTextEntry = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    
    
    
    lazy var rememberCardCheck: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "rave_check_box",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var rememberCardText: UILabel = {
        let label = UILabel()
        label.text = "Remember this card next time"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hex: "#4A4A4A")
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    lazy var cardPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = KlashaConstants.klashaPink
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var whatsCVVButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("What is this?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(UIColor(hex: "#636569"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hex: "#F2F2F2")
        addSubview(titleInfo)
        
        addSubview(cardNumberTextField)
        addSubview(cardExpiry)
        addSubview(cardCVV)
        addSubview(rememberCardCheck)
        addSubview(rememberCardText)
        addSubview(cardPayButton)
        
        
        setupConstriant()
    }
    
    func setupConstriant(){
        NSLayoutConstraint.activate([
            titleInfo.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            titleInfo.topAnchor.constraint(equalTo: topAnchor, constant:20),
            titleInfo.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            titleInfo.heightAnchor.constraint(equalToConstant: 55),
            
            cardNumberTextField.topAnchor.constraint(equalTo: titleInfo.bottomAnchor, constant: 24),
            cardNumberTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardNumberTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardNumberTextField.heightAnchor.constraint(equalToConstant: 50),
            
            cardExpiry.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 30),
            cardExpiry.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardExpiry.heightAnchor.constraint(equalToConstant: 50),
            cardExpiry.widthAnchor.constraint(equalToConstant: 160),
            
            
            cardCVV.topAnchor.constraint(equalTo: cardNumberTextField.bottomAnchor, constant: 30),
            cardCVV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardCVV.widthAnchor.constraint(equalToConstant: 140),
            cardCVV.heightAnchor.constraint(equalToConstant: 50),
           
            
            rememberCardCheck.topAnchor.constraint(equalTo: cardExpiry.bottomAnchor, constant:18),
            rememberCardCheck.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 13),
            rememberCardCheck.heightAnchor.constraint(equalToConstant: 32),
            rememberCardCheck.widthAnchor.constraint(equalToConstant: 39),
            
            
            rememberCardText.leadingAnchor.constraint(equalTo: rememberCardCheck.trailingAnchor, constant: 6),
            rememberCardText.centerYAnchor.constraint(equalTo: rememberCardCheck.centerYAnchor),
            
            cardPayButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            cardPayButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            cardPayButton.topAnchor.constraint(equalTo: rememberCardCheck.bottomAnchor, constant: 20),
            cardPayButton.heightAnchor.constraint(equalToConstant: 50),
            
            rememberCardText.bottomAnchor.constraint(equalTo: cardPayButton.topAnchor, constant: -6)
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
