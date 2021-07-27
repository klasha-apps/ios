import UIKit
import RxSwift

class USSDConfirmViewController: BaseViewController {
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ussdInfoTitleLabel: UILabel!
    @IBOutlet weak var ussdCodeLabel: UILabel!
    @IBOutlet weak var referenceCodeLabel: UILabel!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var completePayment: UIButton!
    var amount: String?
    override func viewDidLoad(){
        view.backgroundColor = .white
        displayAmountAndEmail()
        configureVM()
    }
    
    func displayAmountAndEmail(){
        emailLabel.text = KlashaConfig.sharedConfig().email
        amountLabel.text = "\(self.amount?.toCountryCurrency(code: KlashaConfig.sharedConfig().currencyCode) ?? "")"
    }
}

extension USSDConfirmViewController{
    func configureVM(){
//        BankViewModel.sharedViewModel.changeUSSDText.subscribe(onNext: { text in
//            print("observed \(text)")
//            self.ussdCodeLabel.text = text
//
//        } ).disposed(by: disposableBag)

        self.ussdCodeLabel.text = BankViewModel.sharedViewModel.ussdBankText
        BankViewModel.sharedViewModel.referenceText.subscribe(onNext: { text in
            self.referenceCodeLabel.text = text

        } ).disposed(by: disposableBag)


        self.copyButton.rx.tap.subscribe(onNext: {
            let pasteboard = UIPasteboard.general
            pasteboard.string = BankViewModel.sharedViewModel.ussdBankText
            showSnackBarWithMessage(msg: "USSD code copied")
        }).disposed(by: disposableBag)
    }
}
