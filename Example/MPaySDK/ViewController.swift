//
//  ViewController.swift
//  MPaySDK
//
//  Created by sandeepo2o on 10/06/2019.
//  Copyright (c) 2019 sandeepo2o. All rights reserved.
//

import UIKit
import MPaySDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let vc = UserDetailsVC.instantiateVC();
        self.present(vc, animated: true, completion: nil);

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

