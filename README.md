# klashapay

[![CI Status](https://img.shields.io/travis/debugher/klashapay.svg?style=flat)](https://travis-ci.org/debugher/klashapay)
[![Version](https://img.shields.io/cocoapods/v/klashapay.svg?style=flat)](https://cocoapods.org/pods/klashapay)
[![License](https://img.shields.io/cocoapods/l/klashapay.svg?style=flat)](https://cocoapods.org/pods/klashapay)
[![Platform](https://img.shields.io/cocoapods/p/klashapay.svg?style=flat)](https://cocoapods.org/pods/klashapay)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

klashapay is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'klashapay'
```

## License

klashapay is available under the MIT license. See the LICENSE file for more info.

# klashapay
 
**klasha iOS SDK** allows you to build a quick, simple and excellent payment experience in your iOS app. We provide powerful and customizable UI screens and elements that can be used out-of-the-box to collect your users' payment details.

 
## Example
 
 To run the example project, clone the repo, and open `klashapay.xcworkspace` in the Example directory with **Xcode**, run and build and you are good to go!
 
1. Fill in the following `config details` in the `Viewcontroller.swift` to configure your payment type
 
```
config.currencyCode = "[NGN,USD,KES,RWF,ZAR,GBP,GHS,ZMF,XAF,XOF, e.t.c ]" // This is the specified currency to charge in.
config.email = "user@flw.com" // This is the email address of the customer
config.isStaging = false // Toggle this for staging and live environment
config.phoneNumber = "077883***1" //Phone number
config.transcationRef = "IOS TEXT" // This is a unique reference, unique to the particular transaction being carried out. It is generated when it is not provided by the merchant for every transaction.
config.firstName = "Yemi" // This is the customers first name.
config.lastName = "Desola" //This is the customers last name.
config.meta = [["metaname":"sdk", "metavalue":"ios"]] //This is used to include additional payment information
config.publicKey = "[PUB_KEY]" //Public key
config.encryptionKey = "[ENCRYPTION_KEY]" //Encryption key
guard let controller = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "KlashaPayLandingViewController") as? KlashaPayLandingViewController else {
    fatalError("Unable to Instantiate KlashaPayLandingViewController")
 }
let nav = UINavigationController(rootViewController: controller)
controller.amount = "[]" // This is the amount to be charged.
controller.delegate = self
nav.navigationBar.backgroundColor = .clear
UINavigationBar.appearance().barTintColor = UIColor(hex: "#E75241")
UINavigationBar.appearance().tintColor = .white
UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
UINavigationBar.appearance().isTranslucent = true
self.present(nav, animated: true)
```
 
After this is done, you can make test payments, please ensure `config.isStaging = true`,  

*Please note that the test cards will not work with Live API keys, they will only work on the staging environment.*
 
 
## Requirements
Klashapay is compatible with iOS apps running on iOS 11.0 and above. It requires Xcode 10.0+ to build the source.
 
 
## Usage
 
```swift
 
import klashapay
 
class ViewController: UIViewController, KlashaPayProtocol {
 
    func fundWithKlashaWalletTransactionSuccessful(txRef: String?, responseData: KlashaWalletMakePaymentResponse?) {
        print("Fund with Klasha Wallet Successful")
    }
    
    func fundWithKlashaWalletTransactionFailed(txRef: String?, responseData: KlashaWalletMakePaymentResponse?) {
        print( "Funding with Klasha Wallet Failed to return data with FlwRef \(txRef.orEmpty())")
    }
    
    func onDismiss() {
        print("View controller was dimissed ")
    }
    
    
    func tranasctionSuccessful(txnRef: String?, responseData: ValidateCardPaymentResponse?) {
        print("DATA Returned \(responseData?.txRef ?? "Failed to return data")")
    }
    
    func tranasctionFailed(flwRef: String?, responseData: ValidateCardPaymentResponse?) {
        print( "Failed to return data with FlwRef \(flwRef.orEmpty())")
    }
    
let flutterLabel = UILabel()
let exampleLabel = UILabel()
let underLineView = UIView()
let launchButton = UIButton(type: .system)
 
 
 
    @objc func showExample(){
        
        let config = KlashaConfig.sharedConfig()
        
        config.currencyCode = "KES" // This is the specified currency to charge in.
        config.email = "bayo67@gmail.com" // This is the email address of the customer
        config.isStaging = true // Toggle this for staging and live environment
        config.phoneNumber = "07067783334" //Phone number
        config.transcationRef = "trial-rewt-nfue-vbgf" // This is a unique reference, unique to the particular transaction being carried out. It is generated when it is not provided by the merchant for every transaction.
        config.firstName = "Yemi" // This is the customers first name.
        config.lastName = "Desola" //This is the customers last name.
        config.meta = [["metaname":"sdk", "metavalue":"ios"]] //This is used to include additional payment information
        config.publicKey = "FLWPUBK_TEST-dcc5e2d5d6be710a6ce032c82402ad88-X" //Public key
        config.encryptionKey = "FLWSECK_TEST4d4d7784847f" //Encryption key
        guard let controller = UIStoryboard(name: "KlashaSB", bundle: Bundle.getResourcesBundle()).instantiateViewController(withIdentifier: "KlashaPayLandingViewController") as? KlashaPayLandingViewController else {
            fatalError("Unable to Instantiate KlashaPayLandingViewController")
        }
       let nav = UINavigationController(rootViewController: controller)
        controller.amount = "50" // This is the amount to be charged.
        controller.delegate = self
        nav.navigationBar.backgroundColor = .clear
        UINavigationBar.appearance().barTintColor = UIColor(hex: "#E75241")
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
        self.present(nav, animated: true)
        
    }
 
```
