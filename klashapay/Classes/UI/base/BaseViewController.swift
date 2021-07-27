import UIKit
import RxSwift
import Network


public class BaseViewController: UIViewController{
    let disposableBag = DisposeBag()
   
    override public func viewDidLoad() {
    super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
    
    
    func setUpMoveToWebView(baseViewModel:BaseViewModel, action:@escaping (String,String) -> Void){
        
        baseViewModel.moveToWebViewNext.subscribe(onNext: {response in
            let ref = response.0 ?? ""
            action(response.1.meta?.authorization?.redirect ?? "",ref)
        }).disposed(by: disposableBag)
    }
//    
//    
//    func setUpMoveToOTP(baseViewModel:BaseViewModel, action:@escaping (String,String,TransactionSource) -> Void){
//         
//         baseViewModel.moveToOTPNext.subscribe(onNext: {response in
//             let ref =
//                action(response.0 ?? "",response.1,response.2)
//         }).disposed(by: disposableBag)
//     }
     
    
    func setUpLoadingObservers(baseViewModel:BaseViewModel){
        baseViewModel.isLoading.subscribe(onNext: { isLoading in
            DispatchQueue.main.async {
                if(isLoading){
                    LoadingHUD.shared().show()
                }else{
                    LoadingHUD.shared().hide()
                }
            }
            
        } ).disposed(by: disposableBag)
    }
    

}
