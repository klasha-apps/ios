import Foundation
import RxSwift

class BaseViewModel {
    let userdefaults = UserDefaults.standard
    static let baseRepo = BaseRepository()
    let disposableBag = DisposeBag()
    public let error:PublishSubject<String> = PublishSubject()
    public let isLoading:PublishSubject<Bool> = PublishSubject()
    let moveToPinNext = PublishSubject<String>()
    let moveToOTPNext = PublishSubject<(String,String,TransactionSource)>()
    let moveToWebViewNext = PublishSubject<(String,FlutterChargeResponse)>()
    let moveToAddressVerificationNext = PublishSubject<(String,FlutterChargeResponse)>()
    
    
    func checkAuth(response:FlutterChargeResponse?,flwRef:String,source:TransactionSource){
        let authMode = response?.meta?.authorization?.mode ?? ""
        if let flutterResponse = response{
            print("Current Auth Mode \(authMode)")
            switch authMode{
            case "pin":
                self.moveToPinNext.onNext("")
            case "otp":
                self.moveToOTPNext.onNext((response?.meta?.authorization?.validateInstructions ?? "",flwRef,source))
            case "redirect":
                self.moveToWebViewNext.onNext((flwRef,flutterResponse))
            case "callback":
                print("")
               // PaymentServicesViewModel.sharedViewModel.mpesaVerify(flwRef: flwRef)
            case "avs_noauth":
                self.moveToAddressVerificationNext.onNext((flwRef,flutterResponse))
            default:
                print("")
                //PaymentServicesViewModel.sharedViewModel.mpesaVerify(flwRef: flwRef)
                break
            }
        }
        
    }
    
    func makeAPICallRx <R:Codable,T:Codable>(request:R,apiRequest:(R) -> Observable<NetworkResult<T>>,successHandler:PublishSubject<T>,showLoading:Bool = true,onSuccessOperation:((T) -> ())? = nil
                                             ,showError:Bool = true,onFailureOperation: (() -> () )? = nil,handleFailureOperation:((T) -> () )? = nil ,handleLoading:PublishSubject<Bool>? = nil,apiName:FeaturesTrackerName? = nil,apiErrorName:FeaturesTrackerName? = nil){
        
        let startDate = Date()
        if let handleLoadingCustom = handleLoading {
            handleLoadingCustom.onNext(true)
        }else{
            if(showLoading){
                self.isLoading.onNext(true)
            }
        }
        
        
        apiRequest(request).subscribe(onNext: { response in
            if let handleLoadingCustom = handleLoading {
                handleLoadingCustom.onNext(false)
            }else{
                if(showLoading){
                    self.isLoading.onNext(false)
                }
            }
            let executionTime = Date().timeIntervalSince(startDate)
            let time = executionTime.stringFromTimeInterval()
            
            if case let .success(data) = response {
                successHandler.onNext(data)
                onSuccessOperation?(data)
                if let title = apiName{
                   // self.monitorApiCalls(title: title, message: time)
                }
            }else if case let .failure(errorMessage,data) = response {
                if(showError){
                    if let handleFailure = handleFailureOperation {
                        if let responseData = data{
                            handleFailure(responseData)
                        }
                    }else{
                        self.error.onNext(errorMessage)
                        onFailureOperation?()
                    }
                    
                }
                if let title = apiErrorName{
                   // self.monitorApiCalls(title: title, message: time,error: errorMessage)
                }
                
            }else if case let .error(error) = response{
                print(error?.localizedDescription ?? "Error")
                if(showError){
                    self.error.onNext("Something went wrong")
                }
                if let title = apiErrorName{
                 //   self.monitorApiCalls(title: title, message: time,error: error?.localizedDescription ?? "Something went wrong")
                }
                onFailureOperation?()
            }
            
        }).disposed(by: disposableBag)
        
        
    }
    
    
    func makeGetAPICallRx <T:Codable>(apiRequest:() -> Observable<NetworkResult<T>>,successHandler:PublishSubject<T>,showLoading:Bool = true,onSuccessOperation:((T) -> ())? = nil
                                      ,showError:Bool = true,onFailureOperation: (() -> () )? = nil,handleFailureOperation:((T) -> () )? = nil ,handleLoading:PublishSubject<Bool>? = nil,apiName:FeaturesTrackerName? = nil,apiErrorName:FeaturesTrackerName? = nil){
        
        let startDate = Date()
        if let handleLoadingCustom = handleLoading {
            handleLoadingCustom.onNext(true)
        }else{
            if(showLoading){
                self.isLoading.onNext(true)
            }
        }
        
        
        apiRequest().subscribe(onNext: { response in
            if let handleLoadingCustom = handleLoading {
                handleLoadingCustom.onNext(false)
            }else{
                if(showLoading){
                    self.isLoading.onNext(false)
                }
            }
            let executionTime = Date().timeIntervalSince(startDate)
            let time = executionTime.stringFromTimeInterval()
            
            if case let .success(data) = response {
                successHandler.onNext(data)
                onSuccessOperation?(data)
                if let title = apiName{
                  //  self.monitorApiCalls(title: title, message: time)
                }
            }else if case let .failure(errorMessage,data) = response {
                if(showError){
                    if let handleFailure = handleFailureOperation {
                        if let responseData = data{
                            handleFailure(responseData)
                        }
                    }else{
                        self.error.onNext(errorMessage)
                        onFailureOperation?()
                    }
                    
                }
                if let title = apiErrorName{
                   // self.monitorApiCalls(title: title, message: time,error: errorMessage)
                }
            }else if case let .error(error) = response{
                print(error?.localizedDescription ?? "Error")
                if(showError){
                    self.error.onNext("Something went wrong")
                }
                if let title = apiErrorName{
                    //self.monitorApiCalls(title: title, message: time,error: error?.localizedDescription ?? "Something went wrong")
                }
                onFailureOperation?()
            }
            
        }).disposed(by: disposableBag)
        
        
    }
}


enum TransactionSource {
    case nigerianBankTransfer
    case ghanaMoney
    case ugandaMoney
    case rwandaMoney
    case zambiaMoney
    case francophoneMoney
    
}
