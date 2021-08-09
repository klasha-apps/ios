import UIKit
import WebKit
import RxSwift
protocol  KlashaPayWebProtocol : class{
    func tranasctionSuccessful(flwRef:String,responseData:FlutterwaveDataResponse?)
    
}

class KlashaPayWebViewController: UIViewController, WKNavigationDelegate,WKUIDelegate {
    var webView: WKWebView!
    var url:String?
    var flwRef:String?
    var progressView: UIProgressView!
    let diposableBag = DisposeBag()
    weak var delegate:KlashaPayWebProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _URL = url{
            let ur = _URL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            if let _d = ur{
                let _url = URL(string: _d)
                if let theURL = _url {
                    let request = URLRequest(url: theURL)
                    webView.load(request)
                    webView.allowsBackForwardNavigationGestures = true
                }
            }
        }
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        progressView.tintColor = KlashaConstants.klashaPink
        navigationController?.navigationBar.addSubview(progressView)
        let navigationBarBounds = self.navigationController?.navigationBar.bounds
        progressView.frame = CGRect(x: 0, y: navigationBarBounds!.size.height - 2, width: navigationBarBounds!.size.width, height: 2)
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        setUpObservers()
    }
    
    func setUpObservers(){
//        PaymentServicesViewModel.sharedViewModel.mpesaVerifyResponse.observeOn(MainScheduler.instance).subscribe(onNext: {response in
//            if(response.getStatus() != PaymentState.PENDING){
//                self.delegate?.tranasctionSuccessful(flwRef: response.data?.flwRef ?? "", responseData: response.data?.toFlutterResponse())
//                self.progressView.removeFromSuperview()
//                self.navigationController?.popViewController(animated: true)
//            }
//
//        } ).disposed(by: diposableBag)

        PaymentServicesViewModel.sharedViewModel.error.observeOn(MainScheduler.instance).subscribe(onNext: { error in
            self.progressView.removeFromSuperview()
            showSnackBarWithMessage(msg: error )
            
        } ).disposed(by: diposableBag)
    }
    
    override func loadView() {
        let configuration = WKWebViewConfiguration()
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webView = WKWebView(frame: .zero, configuration: configuration)
        var scriptContent = "var meta = document.createElement('meta');"
        scriptContent += "meta.name='viewport';"
        scriptContent += "meta.content='width=device-width';"
        scriptContent += "document.getElementsByTagName('head')[0].appendChild(meta);"
        webView.evaluateJavaScript(scriptContent, completionHandler: nil)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.navigationDelegate = self
        self.view = webView
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

extension URL {
    public var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            print("Query Term \(item.name)")
            result[item.name] = item.value
        }
    }
}



