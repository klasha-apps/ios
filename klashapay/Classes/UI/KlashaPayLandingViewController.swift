//
//  KlashaPayLandingViewController.swift
//  klashapay
//
//  Created by Adegoke Ayomikun on 02/07/2021.
//

import UIKit

public protocol  KlashaPayProtocol : class{
    func tranasctionSuccessful(txnRef:String?, responseData:ValidateCardPaymentResponse?)
    func tranasctionFailed(flwRef:String?,responseData:ValidateCardPaymentResponse?)
    func fundWithKlashaWalletTransactionSuccessful(txRef: String?, responseData: KlashaWalletMakePaymentResponse?)
    func fundWithKlashaWalletTransactionFailed(txRef: String?, responseData: KlashaWalletMakePaymentResponse?)
    func onDismiss()
}

@available(iOS 11.0, *)
public class KlashaPayLandingViewController: BaseViewController {
    
    @IBOutlet weak var payWithCardView: UIView!
    @IBOutlet weak var payWithBankView: UIView!
    @IBOutlet weak var payWithUssdView: UIView!
    @IBOutlet weak var payWithKlashaWalletView: UIView!
    @IBOutlet weak var payWithMomoView: UIView!
    
    @IBOutlet weak var paymentOptionsTableView: UITableView!
    
    public weak var delegate: KlashaPayProtocol?
    public var amount:String?
    
    var paymentMethods : [PaymentMethod] = []
    
    func getPaymentMethods() -> [PaymentMethod]{
        switch KlashaConfig.sharedConfig().currencyCode {
        case "NGN":
            paymentMethods =  [
                PaymentMethod(methodName: "Card", methodImageName: "card"),
                PaymentMethod(methodName: "Klasha Wallet", methodImageName: "card"),
                PaymentMethod(methodName: "Bank Transfer", methodImageName: "bank")
            ]
        case "GHS":
            paymentMethods =  [
                PaymentMethod(methodName: "Card", methodImageName: "card"),
                PaymentMethod(methodName: "Klasha Wallet", methodImageName: "card"),
                PaymentMethod(methodName: "Bank Transfer", methodImageName: "bank"),
                PaymentMethod(methodName: "Ghana Mobile Money", methodImageName:"phone"),
            ]
        case "KES":
            paymentMethods =  [
                PaymentMethod(methodName: "Card", methodImageName: "card"),
                PaymentMethod(methodName: "Klasha Wallet", methodImageName: "card"),
                PaymentMethod(methodName: "Bank Transfer", methodImageName: "bank"),
                PaymentMethod(methodName: "MPESA", methodImageName: "phone")
            ]
        default:
            paymentMethods = [
                PaymentMethod(methodName: "Card", methodImageName: "card"),
                PaymentMethod(methodName: "Klasha Wallet", methodImageName: "card"),
            ]
        }
        return paymentMethods
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUpObservers()
        cardCallbacks()
     //   setupTableView()
    }
    
//    func addGestureRecognizers(){
//        payWithCardView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPayWithCardViewClicked)))
//        payWithBankView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPayWithBankViewClicked)))
//        payWithKlashaWalletView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPayWithKlashaWalletViewClicked)))
//        payWithUssdView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onPayWithUSSDViewClicked)))
//    }
    
    func onPayWithCardViewClicked(){
        let controller = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "CardDetailsViewController") as! CardDetailsViewController
        controller.amount = amount
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onPayWithGhMoMoClicked(){
        let controller = MobileMoneyGHViewController()
        controller.amount = amount
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onMpesaClicked(){
        let controller = MpesaViewController()
        controller.amount = amount
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onPayWithKlashaWalletViewClicked(){
        let controller = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "KlashaWalletLoginViewController") as! KlashaWalletLoginViewController
        controller.amount = amount
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onPayWithUSSDViewClicked(){
        let controller = USSDSelectBankViewController()
        controller.amount = amount
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func onPayWithBankViewClicked(){
        KlashaBankClient.sharedBankClient.bankTransfer(amount: self.amount ?? "0")
    }
    
    func cardCallbacks(){
        KlashaCardClient.sharedCardClient.transactionReference = KlashaConfig.sharedConfig().transcationRef
        
        KlashaWalletClient.sharedWalletClient.chargeSuccess = {[weak self](txnRef,data) in
            LoadingHUD.shared().hide()
            self?.delegate?.fundWithKlashaWalletTransactionSuccessful(txRef: txnRef, responseData: data)
            self?.dismiss(animated: true, completion: {
                self?.dismiss(animated: true, completion: nil)
            })
            //self?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        
        KlashaCardClient.sharedCardClient.chargeSuccess = {[weak self](txnRef,data) in
            LoadingHUD.shared().hide()
            self?.delegate?.tranasctionSuccessful(txnRef: txnRef,responseData: data)
            self?.dismiss(animated: true, completion: {
                self?.dismiss(animated: true, completion: nil)
            })
            //self?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        
        KlashaCardClient.sharedCardClient.error = {(message,data) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timed out"){
                        showSnackBarWithMessage(msg: "The request timed out", style: .error)
                    }else{
                        showSnackBarWithMessage(msg: message ?? "An error occurred", style: .error)
                    }
                }
            }
        }
        
        KlashaWalletClient.sharedWalletClient.error = {(message,data) in
            LoadingHUD.shared().hide()
            DispatchQueue.main.async {
                if let msg = message{
                    if msg.containsIgnoringCase(find: "timed out"){
                        showSnackBarWithMessage(msg: "The request timed out", style: .error)
                    }else{
                        showSnackBarWithMessage(msg: message ?? "An error occurred", style: .error)
                    }
                }
            }
        }
    }
}

extension KlashaPayLandingViewController{
    
    func setUpObservers(){
        setUpLoading()
        setUpNextActionObservers()
        setUpErrorObservers()
    }
    
    func setUpNextActionObservers(){
        BankViewModel.sharedViewModel.bankTransferResponse.subscribe(onNext: { response in
            let controller = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "PayWithBankViewController") as! PayWithBankViewController
            controller.bankTransferResponse = response
            controller.amount = self.amount
            self.navigationController?.pushViewController(controller, animated: true)
        } ).disposed(by: disposableBag)
    }
    
    func setUpLoading(){
        setUpLoadingObservers(baseViewModel: BankViewModel.sharedViewModel)
    }
    
    func setUpErrorObservers(){
        BankViewModel.sharedViewModel.error.subscribe(onNext: { errorMessage in
            DispatchQueue.main.async {
                showSnackBarWithMessage(msg: errorMessage, style: .error)
                //KlashaCardClient.sharedCardClient.error!(errorMessage,nil)
            }
        }).disposed(by: disposableBag)
    }
}

extension KlashaPayLandingViewController: UITableViewDelegate, UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getPaymentMethods().count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = paymentOptionsTableView?.dequeueReusableCell(withIdentifier: "PaymentMethodsTableViewCell", for: indexPath) as? PaymentMethodsTableViewCell else {
            return UITableViewCell()
        }

        cell.backgroundColor = UIColor.white
        cell.paymentMethodnameLabel.text = getPaymentMethods()[indexPath.row].methodName
        cell.paymentMethodnameLabel.font = Fonts.podFont(name: "Bold.ttf", size: CGFloat(17))
        cell.paymentMethodImageView.image = UIImage(named: getPaymentMethods()[indexPath.row].methodImageName!, in: Bundle.getResourcesBundle(), compatibleWith: nil)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch getPaymentMethods()[indexPath.row].methodName {
        case "Card":
            onPayWithCardViewClicked()
        case "Bank Transfer":
            onPayWithBankViewClicked()
        case "USSD":
            onPayWithUSSDViewClicked()
        case "Klasha Wallet":
            onPayWithKlashaWalletViewClicked()
        case "Ghana Mobile Money":
            onPayWithGhMoMoClicked()
        case "MPESA":
            onMpesaClicked()
        default:
            print("")
        }
    }
}

struct PaymentMethod {
    let methodName: String?
    let methodImageName : String?
}
