import RxSwift

protocol MobileMoneyRepository {
    func mpesa(request:MpesaRequest) -> Observable<NetworkResult<MpesaResponse>>
    
    func ghanaMoney(request:GhanaMobileMoneyRequest) -> Observable<NetworkResult<GhanaMobileMoneyResponse>>
}

class MobileMoneyRepositoryImpl: BaseRepository, MobileMoneyRepository {
    
    func mpesa(request: MpesaRequest) -> Observable<NetworkResult<MpesaResponse>> {
          return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.mpesa, request: request, response: MpesaResponse.self, successCondition: { response in
              response.status == "success"
          }, errorMessage: {response in
              response.message ?? "Something went wrong"
          })
      }
    
    func ghanaMoney(request: GhanaMobileMoneyRequest) -> Observable<NetworkResult<GhanaMobileMoneyResponse>> {
        return makeNetworkPostRequestRx(endPoint: VersionOneServicesApi.ghanaMoney, request: request, response: GhanaMobileMoneyResponse.self, successCondition: { response in
            response.status == "success"
        }, errorMessage: {response in
            response.message ?? "Something went wrong"
        })
    }
}
