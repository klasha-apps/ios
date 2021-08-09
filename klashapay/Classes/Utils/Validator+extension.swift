import UIKit
import MaterialComponents

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case password
    case username
    case projectIdentifier
    case requiredField(field: String)
    case age
    case matches(field:UITextField)
    case matches2(field:MDCOutlinedTextField)
    case phoneNumber
    case acctNumber
    case cardMonth
    case card
    case dob
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        case .username: return UserNameValidator()
        case .projectIdentifier: return ProjectIdentifierValidator()
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .age: return AgeValidator()
        case .matches(let textField): return MatchesFieldValidator(textField)
        case .matches2(let textField): return MatchesFieldValidator2(textField)
        case .phoneNumber: return PhoneNumberValidator()
        case .acctNumber: return AcctNumberValidator()
        case  .cardMonth: return CardMonthValidator()
        case .card: return  CardValidator()
        case .dob: return  DateOfBirthValidator()
        }
    }
}

//"J3-123A" i.e
struct ProjectIdentifierValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z]{1}[0-9]{1}[-]{1}[0-9]{3}[A-Z]$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid Project Identifier Format")
            }
        } catch {
            throw ValidationError("Invalid Project Identifier Format")
        }
        return value
    }
}


class AgeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Age is required")}
        guard let age = Int(value) else {throw ValidationError("Age must be a number!")}
        guard value.count < 3 else {throw ValidationError("Invalid age number!")}
        guard age >= 18 else {throw ValidationError("You have to be over 18 years old to user our app :)")}
        return value
    }
}


struct DateOfBirthValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        
        let day = String(value.prefix(2))
        var month = ""

        //day
            guard Int(day) ?? 0 <= 31 else { throw ValidationError("invalid day") }
        if value.count >= 5 {

         month = value.substring(with: 3..<5)
//            print(month)
            guard Int(month) ?? 0 <= 12 else { throw ValidationError("invalid month") }


        }

        guard value.count == 10 else { throw ValidationError("invalid year") }
      
        return value
    }
}


struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName)
        }
        return value
    }
}

struct MatchesFieldValidator: ValidatorConvertible {
    private let fieldName: UITextField
    
    init(_ field: UITextField) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard value == fieldName.text else {
            throw ValidationError("Fields do not match")
        }
        return value
    }
}

struct MatchesFieldValidator2: ValidatorConvertible {
    private let fieldName: MDCOutlinedTextField
    
    init(_ field: MDCOutlinedTextField) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard value == fieldName.text else {
            throw ValidationError("Fields do not match")
        }
        return value
    }
}

struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count >= 3 else {
            throw ValidationError("Username must contain more than three characters" )
        }
        guard value.count < 18 else {
            throw ValidationError("Username shoudn't conain more than 18 characters" )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-z]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters")
            }
        } catch {
            throw ValidationError("Invalid username, username should not contain whitespaces,  or special characters")
        }
        return value
    }
}

struct PhoneNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        
        guard value.count >= 9 else {
            throw ValidationError("Enter a valid Phone Number" )
        }
        guard value.count < 12 else {
            throw ValidationError("Phone number shoudn't contain more than 12 characters" )
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Password is Required")}
       // guard value.count == 6 else { throw ValidationError("Enter valid 6 digit Password") }
        return value
    }
}

struct AcctNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Account number is Required")}
        guard value.count == 10 else { throw ValidationError("Enter a valid account number") }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid e-mail Address")
            }
        } catch {
            throw ValidationError("Invalid e-mail Address")
        }
        return value
    }
}

struct CardMonthValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        
        guard value.count == 5 else {
            throw ValidationError("Invalid format")
        }
        
        let data = String(value.prefix(2))
//        print("shhs\(data)")
        
        do {
            if try NSRegularExpression(pattern: "^(0[1-9]|1[012])$",  options: .caseInsensitive).firstMatch(in: data, options: [], range: NSRange(location: 0, length: data.count)) == nil {
                throw ValidationError("invalid month of the year")
            }
        } catch {
            throw ValidationError("invalid month of the year")
        }
        return value
    }
}

struct CardValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        var card_type = CardType.Unknown
        
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: value)) {
                card_type = card
                break
                
            }
        }
        
        if card_type.rawValue == "Unknown"{
            throw ValidationError("invalid card format")
            
        }else{
            return card_type.rawValue
        }
        
    }
}



func matchesRegex(regex: String!, text: String!) -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
        let nsString = text as NSString
        let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
        return (match != nil)
        
    } catch {
        
        return false
        
        
    }
}


enum CardType: String {
    case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay, Verve
    
    static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay, Verve]
    
    var regex : String {
        switch self {
        case .Amex:
            return "^3[47][0-9]{5,}$"
        case .Visa:
            return "^4[0-9]{6,}([0-9]{3})?$"
        case .MasterCard:
            return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
        case .Diners:
            return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
        case .Discover:
            return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
        case .JCB:
            return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
        case .UnionPay:
            return "^(62|88)[0-9]{5,}$"
        case .Hipercard:
            return "^(606282|3841)[0-9]{5,}$"
        case .Elo:
            return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
        case .Verve:
            return "^((506(0|1))|(507(8|9))|(6500))[0-9]{12,15}$"
        default:
            return ""
        }
    }
}




