import Foundation
import RxSwift

enum NetworkResult<T>{
    case success(T)
    case failure(String,T?)
    case error(Error?)
    case other(T)
}

struct NetworkingRX {
    var authToken : String = "FYLe4dOZxTjscssKhvOStsBomOEpz2SQOWVugfrdcUA="
    
    func performNetworkTask<R:Codable,T: Codable>(endpoint: EndpointType,
                                                  returnType: T.Type,
                                                  request:R,stage:Stage = Stage.DEV
    ) -> Observable<NetworkResult<T>>
    {
        
        return Observable.create{ observer in
            var urlString:String? = ""
            
            if(stage == Stage.DEV){
                urlString =  endpoint.stagingURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
            }else{
                urlString =  endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
            }
            
            guard let urlRequest = URL(string: urlString ?? "") else {
                return Disposables.create {
                    observer.onError(MyError(msg: "Invalid URL"))
                } }
            var endpointRequest = URLRequest(url: urlRequest)
            endpointRequest.httpMethod = "POST"
            endpointRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            endpointRequest.addValue(authToken, forHTTPHeaderField: "X-Auth-Token")
            endpointRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            #if DEBUG
            print("Public Key is \(KlashaConfig.sharedConfig().publicKey!)")
            print("✅ Request: \(urlString ?? "") \n \(request)\n")
            #else
            #endif
            
            
            do {
                let apiRequest = try JSONEncoder().encode(request)
                endpointRequest.httpBody = apiRequest
            } catch {
                #if DEBUG
                print("❌  Error Encoding JSON: \(urlString ?? "") \n\(error.localizedDescription)")
                #else
                #endif
                
                return Disposables.create {
                    observer.onNext(.error(error))
                }
            }
            
            let urlSession = URLSession.shared.dataTask(with: endpointRequest) { (data, urlResponse, error) in
                if let _ = error {
                    #if DEBUG
                    print("❌  Error :\(urlString ?? "") \n\(error?.localizedDescription ?? "Bad request")")
                    #else
                    #endif
                    
                    observer.onNext(.error(error))
                    return
                }
                guard let data = data else {
                    #if DEBUG
                    print("❌  Error :\(urlString ?? "") ")
                    #else
                    #endif
                    observer.onNext(.error(nil))
                    return
                }
                let response = JsonResponse(data: data)
                
                guard let decoded = response.decode(returnType) else {
                    #if DEBUG
                    print("<<<<<")
                    print(String(describing: error))
                    print("❌  Error Decoding Response : \(urlString ?? "")")
                    #else
                    #endif
                    observer.onNext(.error(nil))
                    return
                }
                #if DEBUG
                print("✅  Response: \(urlString ?? "") \n \(decoded)\n")
                #else
                #endif
                
                observer.onNext(.success(decoded))
                
            }
            urlSession.resume()
            observer.onCompleted()
            return Disposables.create {
                urlSession.cancel()
            }
        }
    }
    
    func performPostRequest<R:Codable,T: Codable>(endpoint: EndpointType,
                                                  returnType: T.Type,
                                                  request:R,stage:Stage = Stage.DEV
    ) -> Observable<NetworkResult<T>>
    {
        
        return Observable.create{ observer in
            var urlString:String? = ""
            if(stage == Stage.DEV){
                urlString =  endpoint.stagingURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
            }else{
                urlString =  endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
            }
            guard let urlRequest = URL(string: urlString ?? "") else { return Disposables.create {
                observer.onError(MyError(msg: "Invalid URL"))
            } }
            var endpointRequest = URLRequest(url: urlRequest)
            endpointRequest.httpMethod = "POST"
            endpointRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            endpointRequest.addValue(authToken, forHTTPHeaderField: "x-auth-token")
            endpointRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            #if DEBUG
            print("Public Key is \(KlashaConfig.sharedConfig().publicKey!)")
            print("✅  Request: \(urlString ?? "") \n \(request)\n")
            #else
            #endif
            
            do {
                let apiRequest = try JSONEncoder().encode(request)
                endpointRequest.httpBody = apiRequest
            } catch {
                #if DEBUG
                print(">>>>>")
                print(String(describing: error))
                print("❌ Error Encoding JSON: \(urlString ?? "") \n\(error.localizedDescription)")
                #else
                #endif
                
                return Disposables.create {
                    observer.onNext(.error(error))
                }
            }
            
            let urlSession = URLSession.shared.dataTask(with: endpointRequest) { (data, urlResponse, error) in
                if let _ = error {
                    #if DEBUG
                    print("❌  Error :\(urlString ?? "") \n\(error?.localizedDescription ?? "Bad request")")
                    #else
                    #endif
                    
                    observer.onNext(.error(error))
                    return
                }
                guard let data = data else {
                    #if DEBUG
                    print("❌  Error :\(urlString ?? "") ")
                    #else
                    #endif
                    
                    observer.onNext(.error(nil))
                    return
                }
                let response = JsonResponse(data: data)
                NetworkLogger.log(request: endpointRequest)
                guard let decoded = response.decode(returnType) else {
                    #if DEBUG
                    print(">>>>>")
                    print(String(describing: error))
                    print("❌  Error Decoding Response : \(urlString ?? "")")
                    #else
                    #endif
                    
                    observer.onNext(.error(nil))
                    return
                }
                
                #if DEBUG
                print("✅  Response: \(urlString ?? "") \n \(decoded)\n")
                #else
                #endif
                observer.onNext(.success(decoded))
            }
            urlSession.resume()
            return Disposables.create {
                urlSession.cancel()
            }
        }
    }
    
    
    func performOrderedGetRequest<T: Codable>(endpoint: EndpointType, parameters: [Int: Any],stage:Stage = Stage.DEV,returnType: T.Type) -> Observable<NetworkResult<T>> {
        
        return Observable.create{ observer in
            var urlString:String? = ""
            if(stage == Stage.DEV){
                urlString =  endpoint.stagingURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
            }else{
                urlString =  endpoint.baseURL.appendingPathComponent(endpoint.path).absoluteString.removingPercentEncoding
            }
           
            
            let sortedParameters =  parameters.sorted(by: {value1 ,value2 in value1.key < value2.key})
            let _parameters = sortedParameters.reduce("", { urlBuilder,parameter in
                "\(urlBuilder)/\(parameter.value)"
            })
            
            urlString = "\(urlString!)\(_parameters)"
            print("✅ GET URL: \(urlString!) ")
            guard let urlRequest = URL(string: urlString ?? "") else { return Disposables.create {
                observer.onError(MyError(msg: "Invalid URL"))
            } }
            
            var endpointRequest = URLRequest(url: urlRequest)
            endpointRequest.httpMethod = "GET"
            endpointRequest.addValue(KlashaConfig.sharedConfig().publicKey!, forHTTPHeaderField: "Authorization")
            endpointRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            #if DEBUG
            print("Public Key is \(KlashaConfig.sharedConfig().publicKey!)")
            #else
            #endif
            
            let urlSession = URLSession.shared.dataTask(with: endpointRequest) { (data, urlResponse, error) in
                if let _ = error {
                    #if DEBUG
                    print("❌  Error :\(urlString ?? "") \n\(error?.localizedDescription ?? "Bad request")")
                    #else
                    #endif
                    
                    observer.onNext(.error(error))
                    return
                }
                guard let data = data else {
                    #if DEBUG
                    print("❌  Error :\(urlString ?? "") ")
                    #else
                    #endif
                    
                    observer.onNext(.error(nil))
                    return
                }
                let response = JsonResponse(data: data)
                guard let decoded = response.decode(returnType) else {
                    #if DEBUG
                    print("❌  Error Decoding Response : \(urlString ?? "")")
                    #else
                    #endif
                    
                    observer.onNext(.error(nil))
                    return
                }
                
                #if DEBUG
                print("✅  Response: \(urlString ?? "") \n \(decoded)\n")
                #else
                #endif
                observer.onNext(.success(decoded))
            }
            urlSession.resume()
            return Disposables.create {
                urlSession.cancel()
            }
        }
    }
}

public struct MyError: Error {
    let msg: String
    
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString(msg, comment: "")
    }
}


enum Stage {
    case PROD
    case DEV
}
