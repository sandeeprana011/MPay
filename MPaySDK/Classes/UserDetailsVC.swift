import UIKit
import WebKit

public class UserDetailsVC: UIViewController {
    @IBOutlet weak var webview: WKWebView!;

    private var delegateOld: (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?;

    var pickedImage: UIImage?;

    public var delegate: DelegateUserDetails?;

    public override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        print("ViewController:", viewControllerToPresent);
        if let viewControllerPicker = viewControllerToPresent as? UIImagePickerController {
            self.delegateOld = viewControllerPicker.delegate;
            viewControllerPicker.delegate = self;
        }
        super.present(viewControllerToPresent, animated: flag, completion: completion)

    }


    override public func viewDidLoad() {
        super.viewDidLoad();
        webview.configuration.userContentController.add(self, name: HandlerType.USER_DETAILS.rawValue);
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
            print(self.pickedImage);
            if let data = (message.body as? String)?.data(using: .utf8) {
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    let userDetails = UserDetails();
                    userDetails.firstName = dict?["firstname"] as? String;
                    userDetails.lastName = dict?["lastname"] as? String;
                    userDetails.profilePicture = self.pickedImage;
                    self.delegate?.onUserDetailsSubmitted(vc: self, userDetails: userDetails);
                } catch {
                    print(error.localizedDescription)
                    self.delegate?.onErrorUserDetails(vc: self, message: "Something Went wrong");
                }
            }
            break;
        default:
            self.delegate?.onUnknownOperationCalledFromJavaScript(vc: self, message: message);
            print("handler not supported");
        }
    }
}

extension UserDetailsVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let newInfo = info
        if let pickedImage = newInfo[UIImagePickerControllerOriginalImage] as? UIImage {
            self.pickedImage = pickedImage;
        }
        self.delegateOld?.imagePickerController!(picker, didFinishPickingMediaWithInfo: info)
        picker.delegate = self.delegateOld
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.delegateOld?.imagePickerControllerDidCancel?(picker);
    }


}

extension String {

    func base64ToImage() -> UIImage? {

        if let decodedData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            let image = UIImage(data: decodedData)
            return image;
        }

        return nil

    }
}
