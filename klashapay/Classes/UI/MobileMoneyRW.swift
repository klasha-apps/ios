import UIKit
import MaterialComponents
class MobileMoneyRW: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your phone number to\nbegin payment."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var mobileMoneyRWPhone: MDCOutlinedTextField = {
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
    
    lazy var mobileMoneyRWPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(mobileMoneyRWPhone)
        addSubview(mobileMoneyRWPayButton)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            titleLabel.heightAnchor.constraint(equalToConstant: 55),
            
            mobileMoneyRWPhone.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mobileMoneyRWPhone.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mobileMoneyRWPhone.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            mobileMoneyRWPhone.heightAnchor.constraint(equalToConstant: 57),
            
            mobileMoneyRWPayButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mobileMoneyRWPayButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            mobileMoneyRWPayButton.topAnchor.constraint(equalTo: mobileMoneyRWPhone.bottomAnchor, constant: 26),
            mobileMoneyRWPayButton.heightAnchor.constraint(equalToConstant: 50),
      ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

   
}
