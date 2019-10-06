import UIKit
import WebKit

public class UserDetailsVC: UIViewController {
    @IBOutlet weak var webview: WKWebView!;

	override public func viewDidLoad() {
        super.viewDidLoad();
        webview.configuration.userContentController.add(self, name: "share");
//		let bundle = Bundle(for: UserDetailsVC.self);
		let frameworkBundle = Bundle(for: UserDetailsVC.self)
		let bundleURL = frameworkBundle.resourceURL?.appendingPathComponent("MPaySDK.bundle");
		let resourceBundle = Bundle(url: bundleURL!);
//		let image = UIImage(named: "ic_arrow_back", inBundle: resourceBundle, compatibleWithTraitCollection: nil)

		
//		let bundle = Bundle(identifier: "MPaySDK")
		let htmlFile = resourceBundle?.path(forResource: "UserDetailsForm", ofType: "html")!;
        let html = try? String(contentsOfFile: htmlFile!, encoding: .utf8)
        webview.loadHTMLString(html!, baseURL: nil)  // Force unwrapping can be used here

    }
	
	public static func instantiateVC() -> UserDetailsVC {
		let storyboard = UIStoryboard(name: "MPay", bundle: Bundle(for: UserDetailsVC.self));
		let vcUserDetails = storyboard.instantiateInitialViewController();
		return vcUserDetails as! UserDetailsVC;
	}
}

// #MARK: WKScriptMessageHandler
extension UserDetailsVC: WKScriptMessageHandler {
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch HandlerType(rawValue: message.name) ?? .NOT_SUPPORTED {
        case HandlerType.USER_DETAILS:
            print("User Details");
            break;
        default:
            print("handler not supported");
        }
    }
}
