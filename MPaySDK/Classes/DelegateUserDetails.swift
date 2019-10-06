//
// Created by Sandeep Rana on 06/10/19.
// Copyright (c) 2019 CocoaPods. All rights reserved.
//

import Foundation
import WebKit

public protocol DelegateUserDetails {
    func onUserDetailsSubmitted(vc: UserDetailsVC, userDetails: UserDetails);
    func onErrorUserDetails(vc: UserDetailsVC, message: String);
    func onUnknownOperationCalledFromJavaScript(vc: UserDetailsVC, message: WKScriptMessage);
}
