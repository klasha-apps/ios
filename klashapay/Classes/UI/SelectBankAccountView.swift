import UIKit
import MaterialComponents

class SelectBankAccountView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Please select your bank"
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
    
    lazy var otherBanksTextField: MDCOutlinedTextField = {
        let text = MDCOutlinedTextField()
        text.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        text.label.text = "Select a Bank"
        text.setFloatingLabelColor(.black, for: .normal)
        text.setFloatingLabelColor(.lightGray, for: .editing)
        text.tintColor = .lightGray
        text.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        text.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin, .flexibleWidth]
        text.setTextColor(.black, for: .editing)
        text.setNormalLabelColor(.lightGray, for: .normal)
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        addSubview(otherBanksTextField)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant:20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            titleLabel.heightAnchor.constraint(equalToConstant: 55),
            
            otherBanksTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            otherBanksTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            otherBanksTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            otherBanksTextField.heightAnchor.constraint(equalToConstant: 57),
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




