import UIKit
import MaterialComponents

class MobileMoneyZM: UIView {

    lazy var mobileMoneyTitle: UILabel = {
           let label = UILabel()
           label.text = "Zambia Money Money"
           label.translatesAutoresizingMaskIntoConstraints = false
           label.textAlignment = .center
           label.numberOfLines = 0
           label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
           return label
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
        text.tintColor = .blue
        text.setNormalLabelColor(.lightGray, for: .normal)
        text.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        text.setTextColor(.black, for: .editing)
        text.setTextColor(.black, for: .normal)
        text.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
        text.setOutlineColor(UIColor(hex: "#F5A623").withAlphaComponent(0.87), for: .editing)
        let redView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        redView.addSubview(arrowButton)
        text.rightView = redView
        text.rightViewMode = .always
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    
    
       
    
    lazy var mobileMoneyPhoneNumber: MDCOutlinedTextField = {
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
       
       lazy var mobileMoneyPay: UIButton = {
           let button = UIButton(type: .system)
           button.setTitle("PAY", for: .normal)
           button.setTitleColor(.white, for: .normal)
          button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
           button.backgroundColor = UIColor(hex: "#F5A623")
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
       
       override init(frame: CGRect) {
           super.init(frame: frame)
           addSubview(mobileMoneyTitle)
           addSubview(stackView)
           stackView.addArrangedSubview(mobileMoneyChooseNetwork)
           stackView.addArrangedSubview(mobileMoneyPhoneNumber)
           stackView.addArrangedSubview(mobileMoneyPay)
           setupConstraints()
       }
       
       func setupConstraints(){
           NSLayoutConstraint.activate([
               mobileMoneyTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
               mobileMoneyTitle.topAnchor.constraint(equalTo: topAnchor, constant:20),
               mobileMoneyTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
               mobileMoneyTitle.heightAnchor.constraint(equalToConstant: 55),
               
               stackView.topAnchor.constraint(equalTo: mobileMoneyTitle.bottomAnchor, constant: 37),
               stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
               stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
               
               
           ])
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

}
