import UIKit

class PaymentStatusPopupViewController: BaseViewController {
    
    @IBOutlet weak var payWithLabel: UILabel!
    var cardPaymentResponse : ValidateCardPaymentResponse?
    var klashaWalletPaymentResponse: KlashaWalletMakePaymentResponse?

    override func viewDidLoad() {
        super.viewDidLoad()
        payWithLabel.textColor = UIColor.lightGray
        payWithLabel.font = Fonts.podFont(name: "Bolds.ttf", size: CGFloat(20))
        // Do any additional setup after loading the view.
    }

    @IBAction func onStatusBtnClicked(_ sender: Any) {
        if cardPaymentResponse != nil{
            if cardPaymentResponse?.status! == "successful"{
                KlashaCardClient.sharedCardClient.chargeSuccess!(cardPaymentResponse?.txRef, cardPaymentResponse)
            }
        }
        
        if klashaWalletPaymentResponse != nil {
            print(klashaWalletPaymentResponse?.tnxStatus)
            if klashaWalletPaymentResponse!.tnxStatus == "SUCCESSFUL"{
                KlashaWalletClient.sharedWalletClient.chargeSuccess!(klashaWalletPaymentResponse?.walletTnxID, klashaWalletPaymentResponse)
            }
        }
       
    }
}
