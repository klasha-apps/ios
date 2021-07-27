import RxSwift
import Swinject

class MobileMoneyViewModel: BaseViewModel{
    
    static let sharedViewModel: MobileMoneyViewModel = Container.sharedContainer.resolve(MobileMoneyViewModel.self)!
    
    let mobileMoneyRepository: MobileMoneyRepository
    let ghanaMoneyResponse = PublishSubject<GhanaMobileMoneyResponse>()
    let mpesaMoneyResponse = PublishSubject<MpesaResponse>()
    var flwRef = ""
    
    init(mobileMoneyRepository: MobileMoneyRepository){
        self.mobileMoneyRepository = mobileMoneyRepository
    }
  
    func ghanaMoney(amount: String, voucher: String, network: String, phoneNumber: String){
        let request = GhanaMobileMoneyRequest(txRef: KlashaConfig.sharedConfig().transcationRef, amount: amount, currency: KlashaConfig.sharedConfig().currencyCode, voucher: voucher, network: network, email: KlashaConfig.sharedConfig().email, phoneNumber: phoneNumber, fullname: "\(KlashaConfig.sharedConfig().firstName.orEmpty()) \(KlashaConfig.sharedConfig().lastName.orEmpty())")
        makeAPICallRx(request: request, apiRequest: mobileMoneyRepository.ghanaMoney(request:), successHandler: ghanaMoneyResponse,onSuccessOperation: {response in
            //self.checkAuth(response: response, flwRef: "",source: .ghanaMoney)
        }, apiName: .ghanaMoney, apiErrorName: .ghanaMoneyError)
    }
    
    func mpesaMoney(amount: String, phoneNumber: String) {
        let request = MpesaRequest(txRef: KlashaConfig.sharedConfig().transcationRef, amount: amount, currency: KlashaConfig.sharedConfig().currencyCode, email:KlashaConfig.sharedConfig().email, phoneNumber: phoneNumber, fullname: "\(KlashaConfig.sharedConfig().firstName.orEmpty()) \(KlashaConfig.sharedConfig().lastName.orEmpty())")
        makeAPICallRx(request: request, apiRequest: mobileMoneyRepository.mpesa(request:), successHandler: mpesaMoneyResponse,onSuccessOperation: { response in
            self.flwRef = response.data?.flwRef ?? ""
//            PaymentServicesViewModel.sharedViewModel.mpesaVerify(flwRef: MobileMoneyViewModel.sharedViewModel.flwRef)
            
        }, apiName: .mpesaMoney, apiErrorName: .mpesaMoneyError)
    }
    
}




