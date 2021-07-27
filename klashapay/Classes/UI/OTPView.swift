import UIKit
import MaterialComponents
class OTPView: UIView {

    lazy var otpMessage: UILabel = {
        let label = UILabel()
        label.text = "Enter the OTP sent your mobile\nnumber 0902801****"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    lazy var otpTextField: MDCOutlinedTextField = {
        let text = MDCOutlinedTextField()
        text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        text.label.text = "OTP"
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
    
  
    
    lazy var otpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("CONFIRM OTP", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.layer.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(otpMessage)
        addSubview(otpTextField)
        addSubview(otpButton)
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            otpMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            otpMessage.topAnchor.constraint(equalTo: topAnchor, constant:20),
            otpMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            otpMessage.heightAnchor.constraint(equalToConstant: 55),
            
            otpTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            otpTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            otpTextField.topAnchor.constraint(equalTo: otpMessage.bottomAnchor, constant: 35),
            otpTextField.heightAnchor.constraint(equalToConstant: 57),

           otpButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
           otpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
           otpButton.topAnchor.constraint(equalTo: otpTextField.bottomAnchor, constant: 26),
           otpButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
