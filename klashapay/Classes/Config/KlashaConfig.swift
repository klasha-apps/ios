import Foundation
public enum SuggestedAuthModel{
    case PIN,AVS_VBVSECURECODE,VBVSECURECODE,GTB_OTP,NOAUTH_INTERNATIONAL,NONE
}
public enum AuthModel{
    case OTP,WEB
}
public class KlashaConfig {
    public var publicKey:String?
    public var encryptionKey:String?
    public var isStaging:Bool = true
    public var email:String?
    public var firstName:String?
    public var lastName:String?
    public var phoneNumber:String?
    public var transcationRef:String?
    public var duration:Double = 2
    public var frequency:Double = 5
    public var country:String = "NG"
    public var currencyCode:String = "NGN"
    public var narration:String?
    public var meta:[[String:String]]?
    
    public class func sharedConfig() -> KlashaConfig {
        struct Static {
            static let kbManager = KlashaConfig()
            
        }
        return Static.kbManager
    }
}
