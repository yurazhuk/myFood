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
    private var authorizer: GTMFetcherAuthorizationProtocol!
    
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
        
//        let controller = DailyFoodController(authorizer)
//
//        self.present(controller, animated: true, completion: nil)
        
//        let controller = NameVC(authorizer)
//        
//        self.present(controller, animated: true, completion: nil)
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


// MARK: - GoogleLoginManagerDelegate

extension LogInController: GoogleLoginManagerDelegate {
    func didFailToLogin(with error: Error) {
        showAlert(title: "Authentication Error", message: error.localizedDescription)
    }
    
    func didLoginSuccessfully(with authorizer: GTMFetcherAuthorizationProtocol) {
        self.signInButton.isHidden = true
        self.authorizer = authorizer
//        presentDailyFoodController(with: authorizer)
        performSegue(withIdentifier: "lol", sender: authorizer)
        self.authorizer = authorizer
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "lol" {
            let destVC = segue.destination as! NameVC
            print(authorizer)
            destVC.sheetsDataProvider = sender as! GTMFetcherAuthorizationProtocol
        }
    }
    
}


