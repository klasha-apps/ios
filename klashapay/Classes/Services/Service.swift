import Foundation

enum VersionTwoServicesApi{
    case getBank
}


extension VersionTwoServicesApi:EndpointType{
    var stagingURL: URL {
         return URL(string: "https://rave-api-v2.herokuapp.com/")!
    }
   
    var baseURL: URL {
        return URL(string: "https://api.ravepay.co/")!
    }

    var path: String {
        switch self {
        case .getBank:
            return "flwv3-pug/getpaidx/api/flwpbf-banks.js?json=1"
        }
    }
}
