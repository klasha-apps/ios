import Foundation
import RxSwift

protocol BankRepository {
   

//    func accountPayment(request:AccountPaymentRequest) -> Observable<NetworkResult<AccountPaymentResponse>>
    
    func bankTransfer(request:BankTransferRequest) -> Observable<NetworkResult<BankTransferResponse>>

    func ussd(request:USSDRequest) -> Observable<NetworkResult<USSDResponse>>
    
    func getbank() -> Observable<NetworkResult<[Bank]>>
    
//    func nigeriaBankTransfer(request:NigeriaBankTransferRequest) -> Observable<NetworkResult<NigeriaBankTransferResponse>>
}

class BankRepositoryImpl: BaseRepository, BankRepository {
   
    
   
//    func accountPayment(request: AccountPaymentRequest) -> Observable<NetworkResult<AccountPaymentResponse>> {
//          return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.nigeriaBankAccount, request: request, response: AccountPaymentResponse.self, successCondition: { response in
//              response.status == "success"
//          }, errorMessage: {response in
//              response.message ?? "Something went wrong"
//          })
//      }
    
    
    func bankTransfer(request: BankTransferRequest) -> Observable<NetworkResult<BankTransferResponse>> {
        return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.bankTransfer, request: request, response: BankTransferResponse.self, successCondition: { response in
            response.status == "success"
        }, errorMessage: {response in
            response.message ?? "Something went wrong"
        })
    }
    
    func ussd(request: USSDRequest) -> Observable<NetworkResult<USSDResponse>> {
        return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.ussd, request: request, response: USSDResponse.self, successCondition: { response in
            response.status == "success"
        }, errorMessage: {response in
            response.message ?? "Something went wrong"
        })
    }
    
//    func nigeriaBankTransfer(request: NigeriaBankTransferRequest) -> Observable<NetworkResult<NigeriaBankTransferResponse>> {
//            return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.nigeriaBankAccount, request: request, response: NigeriaBankTransferResponse.self, successCondition: { response in
//                  response.status == "success"
//              }, errorMessage: { response in
//                  response.message ?? "Something went wrong"
//
//            }, successAction: { response in
//
//            }, failureAction:{ response in
//            })
//          }
    

    
    func getbank() -> Observable<NetworkResult<[Bank]>> {
        return makeOrderedNetworkGetRequest(endPoint: VersionTwoServicesApi.getBank, parameters: [:], response: [Bank].self, successCondition: { response in
            true
        }, errorMessage: {response in
             "Something went wrong(Bank List)"
        })
    }
}
