import RxSwift
import Swinject

class BankViewModel: BaseViewModel{
    
    static let sharedViewModel: BankViewModel = Container.sharedContainer.resolve(BankViewModel.self)!
    
    let bankRepository: BankRepository
    let referenceText = PublishSubject<String>()
    let changeUSSDText = PublishSubject<String>()
    let bankTransferResponse = PublishSubject<BankTransferResponse>()
    let ukAccountResponse = PublishSubject<UKAccountPaymentsResponse>()
    let nigeriaBankAccountResponse = PublishSubject<NigeriaBankTransferResponse>()
    let ussdResponse = PublishSubject<USSDResponse>()
    let bankList = PublishSubject<[Bank]>()
    
    var ussdBankText:String = ""
    var flwRef = ""
    var selectedUSSDBank :USSDBanks?
    
    init(bankRepository: BankRepository){
        self.bankRepository = bankRepository
    }
    
    func bankTransfer(amount: String) {
        let request = BankTransferRequest(txRef: KlashaConfig.sharedConfig().transcationRef, phoneNumber: KlashaConfig.sharedConfig().phoneNumber, amount: amount, currency: KlashaConfig.sharedConfig().currencyCode, email: KlashaConfig.sharedConfig().email)
        makeAPICallRx(request: request, apiRequest: bankRepository.bankTransfer(request:), successHandler: bankTransferResponse, onSuccessOperation: { response in
        }, apiName: .bankTransfer, apiErrorName: .bankTransferError)
    }
    
    func nigeriaBankTransfer(amount: String, accountBank: String, accountNumber: String, phoneNumber: String, passCode:String, bvn:String) {
        let request = NigeriaBankTransferRequest(txRef: KlashaConfig.sharedConfig().transcationRef, amount: amount, accountBank: accountBank, accountNumber: accountNumber, currency: KlashaConfig.sharedConfig().currencyCode, email: KlashaConfig.sharedConfig().email, phoneNumber: phoneNumber, passCode:passCode, bvn:bvn, fullname: "\(KlashaConfig.sharedConfig().firstName.orEmpty()) \(KlashaConfig.sharedConfig().lastName.orEmpty())")
//        makeAPICallRx(request: request, apiRequest: bankRepository.nigeriaBankTransfer(request:),
//                      successHandler: nigeriaBankAccountResponse,onSuccessOperation: { response in
//                        self.checkAuth(response: response.data, flwRef: response.data?.flwRef ?? "", source: .nigerianBankTransfer)
//                        
//                      }, apiName: .directDebit, apiErrorName: .directDebitError)
    }
    
    func ussd(amount: String,ussdBank:USSDBanks?) {
        let request = USSDRequest(txRef: KlashaConfig.sharedConfig().transcationRef, accountBank: ussdBank?.bankCode, amount: amount, currency: KlashaConfig.sharedConfig().currencyCode, email: KlashaConfig.sharedConfig().email, phoneNumber: KlashaConfig.sharedConfig().phoneNumber, fullname: "\(KlashaConfig.sharedConfig().firstName.orEmpty()) \(KlashaConfig.sharedConfig().lastName.orEmpty())")
        makeAPICallRx(request: request, apiRequest: bankRepository.ussd(request:), successHandler: ussdResponse,onSuccessOperation: {response in
            self.selectedUSSDBank = ussdBank
            self.flwRef = response.data?.flwRef ?? ""
            self.processAuth(meta: response.meta)
            
        }, apiName: .ussd, apiErrorName: .ussdError)
    }
    
    func getBanks() {
        makeGetAPICallRx(apiRequest: bankRepository.getbank, successHandler: bankList)
        
    }
    
    
    private func processAuth(meta:Meta?){
        if(meta?.authorization?.mode == "ussd"){
            let note  = meta?.authorization?.note ?? ""
            if let index = note.index(of: "#") {
                let firstPart = note.substring(to: index)
                let lastPart = note.substring(from: index)
                                print("USSD CODES")
                                print(firstPart)
                                print(lastPart)
                if(lastPart.length > 1){
                    self.ussdBankText = String(firstPart)
                    self.referenceText.onNext(String(lastPart).replacingOccurrences(of: "#|", with: ""))
                    self.changeUSSDText.onNext(self.ussdBankText)
                    return
                }else{
                    self.referenceText.onNext("Reference Code")
                }
            }
            
            self.ussdBankText = note.replacingOccurrences(of: "bank_ussd_code", with: self.selectedUSSDBank?.bankUssdCode ?? "")
            self.changeUSSDText.onNext(self.ussdBankText)
            print("USSD CODES \(self.ussdBankText)")
        }
    }
    
}




