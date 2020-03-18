//
//  SigninViewController.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        guard let email = emailField.text,
            let password = passwordField.text,
            let name = nameField.text else { return }
        
        DispatchQueue.global(qos: .background).async {
            Networking.apiEchoPresence.signin(name: name,
                                              email: email,
                                              password: password)
            print(ApiEchoPresence.authToken)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
}

extension SigninViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
