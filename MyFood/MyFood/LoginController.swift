//
//  ViewController.swift
//  MyFood
//
//  Created by yurii zhuk on 6/5/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class LogInController: UIViewController, GIDSignInUIDelegate{
    
    private var signInButton: GIDSignInButton!
    private var loginManager: GoogleLoginManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        configureLoginManager()
        setupLoginButton()
//        setupNameButton()
    }
    
    private func configureLoginManager() {
        self.loginManager = GoogleLoginManager()
        loginManager.delegate = self
        
    }
    
    private func setupLoginButton() {
        // NOTE: - Used default size for button, specify frame size to adjust
        signInButton = GIDSignInButton()
        signInButton.center = view.center
        view.addSubview(signInButton)
    }
    
    private func presentDailyFoodController(with authorizer: GTMFetcherAuthorizationProtocol) {
        
        let controller = DailyFoodController(authorizer)
        
        self.present(controller, animated: true, completion: nil)
        
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.default,
            handler: nil
        )
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}

//func addPulse(for view: UIView) {
//    let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: view.center)
//    pulse.animationDuration = 0.8
//    pulse.backgroundColor = UIColor.blue.cgColor
//
//    view.layer.insertSublayer(pulse, below: view.layer)
//
//}

// MARK: - GoogleLoginManagerDelegate

extension LogInController: GoogleLoginManagerDelegate {
    func didFailToLogin(with error: Error) {
        showAlert(title: "Authentication Error", message: error.localizedDescription)
    }
    
    func didLoginSuccessfully(with authorizer: GTMFetcherAuthorizationProtocol) {
        self.signInButton.isHidden = true
        presentDailyFoodController(with: authorizer)
        
    }
    
    
}


