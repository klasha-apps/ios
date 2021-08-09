import Foundation
protocol EndpointType {

    var baseURL: URL { get }
    var stagingURL:URL{ get }

    var path: String { get }

}
