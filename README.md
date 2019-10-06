# MPaySDK

[![CI Status](https://img.shields.io/travis/sandeepo2o/MPaySDK.svg?style=flat)](https://travis-ci.org/sandeepo2o/MPaySDK)
[![Version](https://img.shields.io/cocoapods/v/MPaySDK.svg?style=flat)](https://cocoapods.org/pods/MPaySDK)
[![License](https://img.shields.io/cocoapods/l/MPaySDK.svg?style=flat)](https://cocoapods.org/pods/MPaySDK)
[![Platform](https://img.shields.io/cocoapods/p/MPaySDK.svg?style=flat)](https://cocoapods.org/pods/MPaySDK)

## Example used MPaySDK

To run the example project, clone the repo, and run `pod install` from the Example directory first.
Then open MPaySDK.xcworkspace in Xcode.
## Note: If Project doesn't compiles or crashes. Please clean the project once.

## Important Classes and Protocols

Class ```UserDetailsVC``` contains the Web Page with First Name, Last Name and Profile Image fields
```UserDetailsVC``` can be instantiated using class function ```instantiateVC```

#### e.g
        let vc = UserDetailsVC.instantiateVC();
        vc.delegate = self;
        self.present(vc, animated: true, completion: nil);
        
```UserDetailsVC``` can be set with delegate ```DelegateUserDetails```

```DelegateUserDetails``` contains three callback methods

    func onUserDetailsSubmitted(vc: UserDetailsVC, userDetails: UserDetails); // Called when user successfully updates the user info
    func onErrorUserDetails(vc: UserDetailsVC, message: String); // Will be called if any error occured
    func onUnknownOperationCalledFromJavaScript(vc: UserDetailsVC, message: WKScriptMessage); // Will be called when there is any unknown or not supported action from Web Page
    
```UserDetails``` contains encapsulated data of the user.    



## Known Issues

1. Selecting image from Files app wouldn't work for now. Support can be extended. Didn't get much to implement it. Because, A hot release is going on in the current company due to festive season.

## Requirements

## Installation

MPaySDK is not available through [CocoaPods](https://cocoapods.org). 
You can still install the project using 
``` ruby
pod 'MPaySDK', :git => 'https://github.com/sandeeprana011/MPay.git', :branch => 'master'
s
```

## Author

sandeeprana011, sandeep.rana011@gmail.com

## License

MPaySDK is available under the MIT license. See the LICENSE file for more info.
