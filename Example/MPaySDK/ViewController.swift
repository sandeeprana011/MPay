//
//  ViewController.swift
//  MPaySDK
//
//  Created by sandeepo2o on 10/06/2019.
//  Copyright (c) 2019 sandeepo2o. All rights reserved.
//

import UIKit
import MPaySDK
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var lFirstName: UILabel!;
    @IBOutlet weak var lLastName: UILabel!;
    @IBOutlet weak var iProfileImage: UIImageView!;

    @IBAction func onClickGetDetailsUsingMishiPay(_ sender: UIButton) {
        self.openUserDetailVC();
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func openUserDetailVC() {
        let vc = UserDetailsVC.instantiateVC();
        vc.delegate = self;
        self.present(vc, animated: true, completion: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: DelegateUserDetails {

    public func onUserDetailsSubmitted(vc: UserDetailsVC, userDetails: UserDetails) {
        self.lFirstName.text = userDetails.firstName;
        self.lLastName.text = userDetails.lastName;
        self.iProfileImage.image = userDetails.profilePicture;
        vc.dismiss(animated: true);
    }

    public func onErrorUserDetails(vc: UserDetailsVC, message: String) {
        print("Error:", message)
        vc.dismiss(animated: true);
    }

    public func onUnknownOperationCalledFromJavaScript(vc: UserDetailsVC, message: WKScriptMessage) {
        print("UnknownOperationFromJavascript", message.name, message.body);
        vc.dismiss(animated: true);
    }
}

