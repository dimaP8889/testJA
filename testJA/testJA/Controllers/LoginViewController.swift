//
//  ViewController.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
        guard let email = emailField.text,
            let password = passwordField.text else { return }
        
        DispatchQueue.global(qos: .background).async {
            Networking.apiEchoPresence.login(email: email,
                                             password: password)
            print(ApiEchoPresence.authToken)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
}

extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
