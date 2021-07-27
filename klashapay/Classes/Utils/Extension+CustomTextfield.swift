import Foundation
import MaterialComponents
import RxSwift
import RxCocoa
extension MDCBaseTextField {
   
    func formatDobText(){
        let text = self.text?.stripDash()
        let customFormatter = DefaultTextFormatter(textPattern: "##-##-####")
        self.text = customFormatter.format(text)
    }
    
    func formatExpiryText(){
        let text = self.text?.stripSlash()
        let customFormatter = DefaultTextFormatter(textPattern: "##/##")
        self.text = customFormatter.format(text)
    }
    
    func formatCardInput(){
        let text = self.text?.stripSlash()
        let customFormatter = DefaultTextFormatter(textPattern: "#### #### #### #### ##### ####")
        self.text = customFormatter.format(text)
    }
  
    
    
    func setCardImage(paymentType:PaymentCardType){
        switch paymentType {
        case .mastercard:
            if let outLinedField = self as? MDCOutlinedTextField {
                outLinedField.setLeadingIconImage(imageName: "rave_mastercard")
            }
            break
        case .visa:
            if let outLinedField = self as? MDCOutlinedTextField {
                outLinedField.setLeadingIconImage(imageName: "rave_visa")
            }
            
            break
        case .verve:
            if let outLinedField = self as? MDCOutlinedTextField {
                outLinedField.setLeadingIconImage(imageName: "rave_visa")
            }
            
            break
        }
    }
    
    
    func validateAndShowError(validationType: ValidatorType)  -> Bool {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        do{
            _ =  try validator.validated(self.text!)
            if let outLinedField = self as? MDCOutlinedTextField {
                outLinedField.setError(error: "")
            }
//            if let filledField = self as? MDCFilledTextField {
//                filledField.setError(error: "")
//            }
            return true
        }catch(let error){
            if let outLinedField = self as? MDCOutlinedTextField {
                outLinedField.setError(error: (error as! ValidationError).message)
                outLinedField.shakeView()
            }
//            if let filledField = self as? MDCFilledTextField {
//                filledField.setError(error: (error as! ValidationError).message)
//                filledField.shakeView()
//            }
            return false
        }
    }
    
    func watchText(validationType: ValidatorType,disposeBag:DisposeBag){
        self.rx.controlEvent(.editingChanged)
            .withLatestFrom(self.rx.text.orEmpty)
            .subscribe(onNext: {text in
                
                _ =    self.validateAndShowError(validationType: validationType)
            }).disposed(by: disposeBag)
    }
    
    
    
    func validateAndShowError2(validationType: ValidatorType)  -> Bool {
             let validator = VaildatorFactory.validatorFor(type: validationType)
             do{
                let text =  self.text
                let type =  try validator.validated((text!.stripSpace()))
                 if let outLinedField = self as? MDCOutlinedTextField {
//                  print(type)
                 
                    outLinedField.setError(error: "", sucessImage:type)
                 }
//                 if let filledField = self as? MDCFilledTextField {
////                  print(type)
//                     filledField.setError(error: "")
//                 }
                 return true
             }catch(let error){
                 if let outLinedField = self as? MDCOutlinedTextField {
                     outLinedField.setError(error: (error as! ValidationError).message)
                 }
//                 if let filledField = self as? MDCFilledTextField {
//                     filledField.setError(error: (error as! ValidationError).message)
//                 }
                 return false
             }
         }
      
      func watchText2(validationType: ValidatorType,disposeBag:DisposeBag){
              self.rx.controlEvent(.editingChanged)
                .withLatestFrom(self.rx.text.orEmpty)
                .subscribe(onNext: {text in
//                       print(text)
                   _ =    self.validateAndShowError2(validationType: validationType)
                   }).disposed(by: disposeBag)
          }
  
    
  
   
    
}



extension MDCOutlinedTextField{
    func setLeadingIconImage(imageName:String){
        let image =  UIImage(named: imageName, in: Bundle.getResourcesBundle()!, compatibleWith: nil)
        if image != nil{
            let email_image = imageWithImage(image:image!,scaledToSize: CGSize(width: 30, height: 18) )
            let email_icon = UIImageView(image: email_image)
            self.leadingView = email_icon
//            self.leadingViewMode = .always
        }
    }
    func setError(error:String,sucessImage:String = "",errorImage:String=""){
        if(error.isEmpty){
            self.leadingAssistiveLabel.text = ""
            self.setFloatingLabelColor(.black, for: .normal)
            self.setFloatingLabelColor(.black, for: .editing)
            self.trailingView = nil
            self.setOutlineColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
            self.setOutlineColor(KlashaConstants.klashaPink.withAlphaComponent(0.87), for: .editing)
 
           if sucessImage != ""{
               let email_image = imageWithImage(image:UIImage(named: sucessImage, in: Bundle.getResourcesBundle()!, compatibleWith: nil) ?? UIImage(),scaledToSize: CGSize(width: 40.0, height: 18.0) )
               let email_icon = UIImageView(image: email_image)
               self.leadingView = email_icon
              self.leadingViewMode = .always
           }
            
            
        }else{
            self.leadingAssistiveLabel.text = error
            self.setLeadingAssistiveLabelColor(.red, for: .normal)
            self.setLeadingAssistiveLabelColor(.red, for: .editing)
            self.setFloatingLabelColor(.red, for: .normal)
            self.setFloatingLabelColor(.red, for: .editing)
            self.setOutlineColor(UIColor.red.withAlphaComponent(0.87), for: .normal)
            self.setOutlineColor(.red, for: .editing)
            
            let image =  UIImage(named: "rave_error_icon", in: Bundle.getResourcesBundle()!, compatibleWith: nil)
            let error_image = imageWithImage(image:image!,scaledToSize: CGSize(width: 20.0, height: 20.0) )
            let error_icon = UIImageView(image: error_image)
            self.trailingView = error_icon
            self.trailingViewMode = .always
            
            if errorImage != ""{
                let error_email_image = imageWithImage(image:UIImage(named: errorImage)!,scaledToSize: CGSize(width: 20.0, height: 15.0) )
                let error_icon2 = UIImageView(image: error_email_image)
                self.leadingView = error_icon2
            }
        }
        
    }
}

extension MDCFilledTextField{
    func setLeadingIconImage(imageName:String){
        let image =  UIImage(named: imageName, in: Bundle.getResourcesBundle()!, compatibleWith: nil)
        if image != nil{
            let email_image = imageWithImage(image:image!,scaledToSize: CGSize(width: 30, height: 18) )
            let email_icon = UIImageView(image: email_image)
            self.leadingView = email_icon
//            self.leadingViewMode = .always
        }
    }
    func setError(error:String,sucessImage:String = "",errorImage:String=""){
        if(error.isEmpty){
            self.leadingAssistiveLabel.text = ""
            self.setFloatingLabelColor(.black, for: .normal)
            self.setFloatingLabelColor(.black, for: .editing)
            self.trailingView = nil
            self.setFilledBackgroundColor(UIColor.lightGray.withAlphaComponent(0.87), for: .normal)
            self.setFilledBackgroundColor(UIColor.lightGray.withAlphaComponent(0.87), for: .editing)
 
           if sucessImage != ""{
               let email_image = imageWithImage(image:UIImage(named: sucessImage, in: Bundle.getResourcesBundle()!, compatibleWith: nil) ?? UIImage(),scaledToSize: CGSize(width: 40.0, height: 18.0) )
               let email_icon = UIImageView(image: email_image)
               self.leadingView = email_icon
              self.leadingViewMode = .always
           }
            
            
        }else{
            self.leadingAssistiveLabel.text = error
            self.setLeadingAssistiveLabelColor(.red, for: .normal)
            self.setLeadingAssistiveLabelColor(.red, for: .editing)
            self.setFloatingLabelColor(.red, for: .normal)
            self.setFloatingLabelColor(.red, for: .editing)
            self.setFilledBackgroundColor(UIColor.red.withAlphaComponent(0.87), for: .normal)
            self.setFilledBackgroundColor(UIColor.red.withAlphaComponent(0.87), for: .editing)
            
            let image =  UIImage(named: "rave_error_icon", in: Bundle.getResourcesBundle()!, compatibleWith: nil)
            let error_image = imageWithImage(image:image!,scaledToSize: CGSize(width: 20.0, height: 20.0) )
            let error_icon = UIImageView(image: error_image)
            self.trailingView = error_icon
            self.trailingViewMode = .always
            
            if errorImage != ""{
                let error_email_image = imageWithImage(image:UIImage(named: errorImage)!,scaledToSize: CGSize(width: 20.0, height: 15.0) )
                let error_icon2 = UIImageView(image: error_email_image)
                self.leadingView = error_icon2
            }
        }
        
    }
}


extension MDCOutlinedTextField {
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}


extension MDCFilledTextField{
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension MDCBaseTextField {
    func formatTextToSlash(textPattern:String){
     let text = self.text?.stripSlash()
             let customFormatter = DefaultTextFormatter(textPattern: textPattern)
     self.text = customFormatter.format(text)
         }
    
    func formatTextToSpace(textPattern:String){
        let text = self.text?.stripSpace()
                let customFormatter = DefaultTextFormatter(textPattern: textPattern)
        self.text = customFormatter.format(text)
            }
    
    func formatTextToDash(textPattern:String){
           let text = self.text?.stripDash()
                   let customFormatter = DefaultTextFormatter(textPattern: textPattern)
           self.text = customFormatter.format(text)
               }
}

extension TimeInterval{

        func stringFromTimeInterval() -> String {

            let time = NSInteger(self)

            let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
            let seconds = time % 60
            let minutes = (time / 60) % 60
            let hours = (time / 3600)

            return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)

        }
    }
