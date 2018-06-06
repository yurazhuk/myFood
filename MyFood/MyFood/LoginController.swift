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
    private var output: UITextView!
    
    private var loginManager: GoogleLoginManager!
    private var sheetsDataProvider: GoogleSheetsDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        
        configureLoginManager()
        configureSheetsDataProvider()
        setupLoginButton()
        configureOutputLog()
        addPulse(for: signInButton)
    }
    
    private func configureLoginManager() {
        self.loginManager = GoogleLoginManager()
        loginManager.delegate = self
        
    }
    
    private func configureSheetsDataProvider() {
        sheetsDataProvider = GoogleSheetsDataProvider()
        sheetsDataProvider.delegate = self
    }
    
    private func setupLoginButton() {
        // NOTE: - Used default size for button, specify frame size to adjust
        signInButton = GIDSignInButton()
        signInButton.center = view.center
        view.addSubview(signInButton)
    }
    
    private func configureOutputLog() {
        self.output = UITextView(frame: view.bounds)
        view.addSubview(output)
        output.isEditable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        output.isHidden = true
        
    }
    
    private func requestDataFromProvider() {
        sheetsDataProvider.listMajors {[weak self] model in
            self?.output.text = model.getMenuItemsString()
        }
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

func addPulse(for view: UIView){
    let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: view.center)
    pulse.animationDuration = 0.8
    pulse.backgroundColor = UIColor.blue.cgColor
    
    view.layer.insertSublayer(pulse, below: view.layer)
    
}

// MARK: - GoogleLoginManagerDelegate

extension LogInController: GoogleLoginManagerDelegate {
    func didFailToLogin(with error: Error) {
        showAlert(title: "Authentication Error", message: error.localizedDescription)
    }
    
    func didLoginSuccessfully(with authorizer: GTMFetcherAuthorizationProtocol) {
        self.signInButton.isHidden = true
        self.output.isHidden = false
        output.text = "Getting sheet data..."
        sheetsDataProvider.updateServiceAuthorizer(to: authorizer)
        requestDataFromProvider()
//        present(DailyFoodScreenController(), animated: true, completion: nil)
    }
}

extension LogInController: GoogleSheetsDataProviderDelegate {
    func didFailFetchingData(with error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
    
}
