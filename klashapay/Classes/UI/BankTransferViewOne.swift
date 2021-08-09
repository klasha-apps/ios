import UIKit

class BankTransferViewOne: UIView {
   
    
    lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PAY", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hex: "#F5A623")
        button.layer.cornerRadius = 4
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.heightAnchor.constraint(equalToConstant: 57).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         addSubview(payButton)
    
         setupConstraints()
     }
   
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            payButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            payButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            payButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            payButton.heightAnchor.constraint(equalToConstant: 50),

        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

