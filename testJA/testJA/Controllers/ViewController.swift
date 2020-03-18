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
        print(Networking.apiEchoPresence.login(email: "lolo123456@123lolo.lol", password: "lololololo"))
        print(Networking.apiEchoPresence.getText())
    }
}

