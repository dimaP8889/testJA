//
//  ViewController.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        Networking.apiEchoPresence.login(email: "test@test.test", password: "testtest123T")
        print(Networking.apiEchoPresence.getText())
    }


}

