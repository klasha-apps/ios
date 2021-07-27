//
//  CardValidation.swift
//  FlutterwaveSDK
//
//  Created by Rotimi Joshua on 30/09/2020.
//  Copyright © 2020 Flutterwave. All rights reserved.
//

import Foundation

public enum PaymentCardType: String {

    internal enum Constants {

        /// Minimum length of card number required before doing number validation.
        static let minimumLengthForValidation = 12
        /// Minimum length of card number required before performing suggestion.
        static let minimumLengthForSuggestion = 4
    }

    case mastercard = "MasterCard"
    case visa = "Visa"
     case verve = "Verve"
//    case verve = "unknown"
    

    /// Helper to return all supported card types.
    public static var all: [PaymentCardType] = [
        .mastercard,
        .visa,
        .verve
    ]

    /**
     Initializer.
     - parameter cardNumber: Credit/Debit card number with which card type should be attempted to
     be made.
     */
    public init?(cardNumber: String) {

        guard let type = PaymentCardType.typeForCardNumber(cardNumber) else {
            return nil
        }

        self.init(rawValue: type.rawValue)
    }

    /**
     Method to get suggested type for a card number.
     - parameter cardNumber: The card number for which suggestion has to be made.
     - returns: The suggestion for card type if any, else nil.
     - note: All card numbers need minimum 4 digits for a suggestion, and for some specific card
     numbers (Eg: MasterCard that starts with 677189 or Visa Electron that starts with 417500),
     minimum 6 digits are needed for a correct suggestion.
     */
    public static func suggestedTypeForCardNumber(_ cardNumber: String?) -> PaymentCardType? {

        guard let cn = cardNumber,
            cn.count >= Constants.minimumLengthForSuggestion else {
                return nil
        }
        return PaymentCardType.all.first {
            return NSPredicate(format: "SELF MATCHES %@", $0.regularExpressionForSuggestion).evaluate(with: cn)
        }
    }

    /// This method actually validates the card number.
    public static func typeForCardNumber(_ cardNumber: String?) -> PaymentCardType? {

        guard let cn = cardNumber else {
            return nil
        }
        return PaymentCardType.all.first {
            return NSPredicate(format: "SELF MATCHES %@", $0.cardNumberRegex).evaluate(with: cn)
        }
    }

    private var cardNumberRegex: String {

        switch self {
        case .mastercard:
            // 16 digits starts with 51-55|2221-2720
            return "^((5[1-5]\\d{4}|677189)\\d{10})|((222[1-9]|22[3-9]\\d|2[3-6]\\d{2}|27[0-1]\\d|2720)\\d{12})$"
        case .visa:
            // 13 or 16 digits. starts with 4
            return "^4\\d{12}(?:\\d{3})?$"
            case .verve:
            // 13 or 16 digits. starts with 4
            return "^4\\d{12}(?:\\d{3})?$"
        }
        
    }

    private var regularExpressionForSuggestion: String {

        switch self {
        case .mastercard:
            return "^((5[1-5]|677189)\\d*)|((222[1-9]|22[3-9]\\d|2[3-6]\\d{2}|27[0-1]\\d|2720)\\d*)$"
        case .visa:
            return "^4\\d*$"
        case .verve:
            return "^4\\d*$"
        }
    }
}
