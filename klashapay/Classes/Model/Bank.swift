import UIKit

struct Bank: Codable {
    var bankCode:String?
    var isInternetBanking:Bool?
    var name:String?
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bankCode = try values.decodeIfPresent(String?.self, forKey: .bankCode) ?? nil
        isInternetBanking = try values.decodeIfPresent(Bool?.self, forKey: .isInternetBanking) ?? nil
        name = try values.decodeIfPresent(String?.self, forKey: .name) ?? nil
    }
}

extension Bank{
    enum CodingKeys:String,CodingKey{
        case name = "bankname"
        case isInternetBanking = "internetbanking"
        case bankCode = "bankcode"
    }
}

