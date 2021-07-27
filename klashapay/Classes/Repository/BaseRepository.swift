import Foundation
import RxSwift

class BaseRepository {
    //    let networkHelper = Networking()
    let networkHelperRX = NetworkingRX()
    let disposableBag = DisposeBag()
    
    func makeNetworkPostRequestRx<R:Codable,T:Codable>(endPoint:EndpointType,request: R,response:T.Type,successCondition:@escaping (T) -> Bool,errorMessage:@escaping (T)->String,successAction:((T) -> ())? = nil, failureAction:((T) -> ())? = nil ) -> Observable<NetworkResult<T>> {
        
        return Observable.create{ observer in
            let requestObserver =    self.networkHelperRX.performPostRequest(endpoint: endPoint, returnType: T.self, request: request,stage: self.getStage()).subscribe(onNext: { response in
                if case let .success(data) = response{
                    if(successCondition(data)){
                        DispatchQueue.main.async {
                            observer.onNext(.success(data))
                            successAction?(data)
                        }
                    } else{
                        observer.onNext(.failure(errorMessage(data),data))
                        failureAction?(data)
                    }} else if case let .error(error) = response {
                        observer.onNext(.error(error))
                    }
            })
            return Disposables.create {
                requestObserver.dispose()
            }
        }
    }
    
    func makeBackgroundNetworkPostRequestRx<R:Codable,T:Codable>(endPoint:EndpointType,request: R,response:T.Type,successCondition:@escaping (T) -> Bool,successAction:((T) -> ())? = nil ) {
        
        self.networkHelperRX.performPostRequest(endpoint: endPoint, returnType: T.self, request: request,stage: getStage()).subscribe(onNext: {response in
            if case let .success(data) = response{
                if(successCondition(data)){
                    DispatchQueue.global(qos: .background).async {
                        successAction?(data)
                    }
                } else{
                    
                }} else if case .error(_) = response {
                    
                }
        } ).disposed(by: disposableBag)
    }
    
    func makeOrderedNetworkGetRequest<T:Codable>(endPoint:EndpointType,parameters: [Int:Any],response:T.Type,successCondition:@escaping (T) -> Bool,errorMessage:@escaping (T)->String,successAction:((T) -> ())? = nil, failureAction:((T) -> ())? = nil ) -> Observable<NetworkResult<T>> {
        
        return Observable.create{ observer in
            let requestObserver =    self.networkHelperRX.performOrderedGetRequest(endpoint: endPoint, parameters: parameters, stage: self.getStage(), returnType: T.self).subscribe(onNext: { response in
                if case let .success(data) = response{
                    if(successCondition(data)){
                        DispatchQueue.main.async {
                            observer.onNext(.success(data))
                            successAction?(data)
                        }
                    } else{
                        observer.onNext(.failure(errorMessage(data),data))
                        failureAction?(data)
                    }} else if case let .error(error) = response {
                        observer.onNext(.error(error))
                    }
                
            })
            return Disposables.create {
                requestObserver.dispose()
            }
        }
    }
    
    func getStage() -> Stage{
        if(KlashaConfig.sharedConfig().isStaging){
            return Stage.DEV
        }else{
            return Stage.PROD
        }
    }
}
