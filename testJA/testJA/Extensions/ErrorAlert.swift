//
//  ErrorAlert.swift
//  testJA
//
//  Created by Dmytro Pogrebniak on 18.03.2020.
//  Copyright © 2020 dima. All rights reserved.
//

import UIKit
//import SVProgressHUD

protocol ErrorAlert {
    
    func presentAlert(with message : String)
}

extension ErrorAlert {
    
    func presentAlert(with message : String) {
        
        DispatchQueue.main.async {
            
            //SVProgressHUD.dismiss()
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let alertButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(alertButton)
            
            alertController.presentGlobally(animated: true, completion: nil)
        }
    }
}

extension UIAlertController {
     
    private static var globalPresentationWindow: UIWindow?
     
    func presentGlobally(animated: Bool, completion: (() -> Void)?) {
        
        guard UIAlertController.globalPresentationWindow == nil else { return }
        
        UIAlertController.globalPresentationWindow = UIWindow(frame: UIScreen.main.bounds)
        UIAlertController.globalPresentationWindow?.rootViewController = UIViewController()
        UIAlertController.globalPresentationWindow?.windowLevel = UIWindow.Level.alert + 1
        UIAlertController.globalPresentationWindow?.backgroundColor = .clear
        UIAlertController.globalPresentationWindow?.makeKeyAndVisible()
        UIAlertController.globalPresentationWindow?.rootViewController?.present(self, animated: animated, completion: completion)
    }
     
    open override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        UIAlertController.globalPresentationWindow = nil
    }
     
}
