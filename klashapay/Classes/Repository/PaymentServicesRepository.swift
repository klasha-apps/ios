import Foundation
import RxSwift

protocol PaymentServicesRepository {
    
    func sendCardPayment(request:SendCardPaymentRequest) -> Observable<NetworkResult<SendCardPaymentResponse>>
    
    func chargeCard(request:ChargeCardRequest) -> Observable<NetworkResult<ChargeCardResponse>>
    
    func validateCardPayment(request:ValidateCardPaymentRequest) -> Observable<NetworkResult<ValidateCardPaymentResponse>>
    
    func klashaWalletLogin(request: KlashaWalletLoginRequest) -> Observable<NetworkResult<KlashaWalletLoginResponse>>
    
    func payWithKlashaWallet(request: KlashaWalletMakePaymentRequest) -> Observable<NetworkResult<KlashaWalletMakePaymentResponse>>
    
    func getExchangeRate(request: GetExchangeRateRequest) -> Observable<NetworkResult<GetExchangeRateResponse>>
}

class PaymentServicesRepositoryImpl: BaseRepository, PaymentServicesRepository {
    func getExchangeRate(request: GetExchangeRateRequest) -> Observable<NetworkResult<GetExchangeRateResponse>> {
        return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.exchangeRate, request: request, response: GetExchangeRateResponse.self, successCondition: {response in
            response.rate != nil && String(response.rate!) != ""
        }, errorMessage: {response in
            return ("Failed to fetch exchange rate")
        })
    }
    
    func payWithKlashaWallet(request: KlashaWalletMakePaymentRequest) -> Observable<NetworkResult<KlashaWalletMakePaymentResponse>> {
        return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.payWithKlashaWallet, request: request, response: KlashaWalletMakePaymentResponse.self, successCondition: {response in
            response.tnxStatus == "SUCCESSFUL"
        }, errorMessage: {response in
            return (response.error ?? "Something went wwrong")
        })
    }
    
    func klashaWalletLogin(request: KlashaWalletLoginRequest) -> Observable<NetworkResult<KlashaWalletLoginResponse>> {
        return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.klashaWalletLogin, request: request, response: KlashaWalletLoginResponse.self, successCondition: {response in
            response.email != nil
        }, errorMessage: {response in
            return (response.error ?? "Something went wwrong")
        })
    }
    
    
    func sendCardPayment(request: SendCardPaymentRequest) -> Observable<NetworkResult<SendCardPaymentResponse>> {
        return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.sendCardPayment, request: request, response: SendCardPaymentResponse.self, successCondition: { response in
            response.data?.status == "success" || response.data?.flwRef != nil
        }, errorMessage: {response in
            return (response.data?.message ?? "Something went wrong")
        })
    }
    
    func chargeCard(request: ChargeCardRequest) -> Observable<NetworkResult<ChargeCardResponse>> {
        return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.chargeCard, request: request, response: ChargeCardResponse.self, successCondition: { response in
            response.status == "pending"
        }, errorMessage: {response in
            response.message ?? "Something went wrong"
        })
    }
    
    func validateCardPayment(request: ValidateCardPaymentRequest) -> Observable<NetworkResult<ValidateCardPaymentResponse>> {
        return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.validateCardPayment, request: request, response: ValidateCardPaymentResponse.self, successCondition: { response in
            response.status == "successful"
        }, errorMessage: {response in
            response.message ?? "Something went wrong"
        })
    }
}
