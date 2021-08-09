import UIKit

class BankTransferViewTwo: UIView {
    
    lazy var infoTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Please proceed to your banking app to complete this bank transfer."
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.textColor = UIColor(hex: "#808080")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var amountValue: UILabel = {
        let label = UILabel()
        label.text = "NGN 10000000000"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var amountLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E1E2E2").withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var accountLabel: UILabel = {
        let label = UILabel()
        label.text = "Account Number"
        label.textColor = UIColor(hex: "#808080")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var accountValue: UILabel = {
        let label = UILabel()
        label.text = "7829450587"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var accountLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E1E2E2").withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var bankLabel: UILabel = {
        let label = UILabel()
        label.text = "Bank Name"
        label.textColor = UIColor(hex: "#808080")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var bankValue: UILabel = {
        let label = UILabel()
        label.text = "WEMA BANK"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var bankLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E1E2E2").withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    lazy var beneficiaryLabel: UILabel = {
        let label = UILabel()
        label.text = "Beneficiary Name"
        label.textColor = UIColor(hex: "#808080")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var beneficiaryValue: UILabel = {
        let label = UILabel()
        label.text = "FLUTT"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var copyButton: UIButton = {
           let button = UIButton(type: .custom)
           button.setImage(UIImage(named: "rave_copy_icon",in: Bundle.getResourcesBundle(), compatibleWith: nil), for: .normal)
           button.tintColor = UIColor(hex: "#647482")
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
           
       }()
    
    lazy var beneficiaryLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#E1E2E2").withAlphaComponent(0.6)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var completePayment: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("I HAVE MADE THIS BANK TRANSFER", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.layer.cornerRadius = 4
        button.heightAnchor.constraint(equalToConstant: 57).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(infoTitleLabel)
        addSubview(amountLabel)
        addSubview(amountValue)
        addSubview(amountLineView)
        addSubview(copyButton)
        addSubview(accountLabel)
        addSubview(accountValue)
        addSubview(accountLineView)
        addSubview(bankLabel)
        addSubview(bankValue)
        addSubview(bankLineView)
        addSubview(beneficiaryLabel)
        addSubview(beneficiaryValue)
        addSubview(beneficiaryLineView)
        addSubview(completePayment)
        
        setupConstraints()
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            infoTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            infoTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant:20),
            infoTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            
            
            amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            amountLabel.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant:30),
            
            amountValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            amountValue.topAnchor.constraint(equalTo: infoTitleLabel.bottomAnchor, constant:30),
            
            
            
            amountLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            amountLineView.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant:10),
            amountLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            amountLineView.heightAnchor.constraint(equalToConstant: 1),
            
            
            accountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            accountLabel.topAnchor.constraint(equalTo: amountLineView.bottomAnchor, constant:20),
            
            copyButton.leadingAnchor.constraint(equalTo: accountLabel.trailingAnchor, constant:10),
            copyButton.topAnchor.constraint(equalTo: amountLineView.bottomAnchor, constant:20),
            copyButton.widthAnchor.constraint(equalToConstant: 18),
                        copyButton.heightAnchor.constraint(equalToConstant: 18),
            
            accountValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            accountValue.topAnchor.constraint(equalTo: amountLineView.bottomAnchor, constant:20),
            
            accountLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            accountLineView.topAnchor.constraint(equalTo: accountLabel.bottomAnchor, constant:10),
            accountLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            accountLineView.heightAnchor.constraint(equalToConstant: 1),
            
            bankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            bankLabel.topAnchor.constraint(equalTo: accountLineView.bottomAnchor, constant:20),
            
            bankValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            bankValue.topAnchor.constraint(equalTo: accountLineView.bottomAnchor, constant:20),
            
            bankLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            bankLineView.topAnchor.constraint(equalTo: bankLabel.bottomAnchor, constant:10),
            bankLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            bankLineView.heightAnchor.constraint(equalToConstant: 1),
            
            beneficiaryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            beneficiaryLabel.topAnchor.constraint(equalTo: bankLineView.bottomAnchor, constant:20),
            
            beneficiaryValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            beneficiaryValue.topAnchor.constraint(equalTo: bankLineView.bottomAnchor, constant:20),
            
            beneficiaryLineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            beneficiaryLineView.topAnchor.constraint(equalTo: beneficiaryLabel.bottomAnchor, constant:10),
            beneficiaryLineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            beneficiaryLineView.heightAnchor.constraint(equalToConstant: 1),
            
            completePayment.leadingAnchor.constraint(equalTo: leadingAnchor, constant:20),
            completePayment.topAnchor.constraint(equalTo: beneficiaryLineView.bottomAnchor, constant:40),
            completePayment.trailingAnchor.constraint(equalTo: trailingAnchor, constant:-20),
            completePayment.heightAnchor.constraint(equalToConstant: 50)
         
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
