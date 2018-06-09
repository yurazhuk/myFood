//
//  NameVC.swift
//  MyFood
//
//  Created by yurii zhuk on 6/8/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import GoogleSignIn
import GoogleAPIClientForREST
import UIKit

class NameVC: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    var token: GTMFetcherAuthorizationProtocol!
    private var userIsLogedIn: Bool{
        return UserDefaults.standard.isLoggedIn()
    }
    
    override func viewDidLoad() {
        if userIsLogedIn {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "presentDailyFood", sender: self.token)
            }} else {
            backgroundImage.image = UIImage(named: "background")
            view.addSubview(backgroundImage)
            loginButton.layer.masksToBounds = true
            loginButton.layer.cornerRadius = loginButton.frame.size.height / 2
            loginButton.isHidden = false
            loginButton.setGradientBackground(colorOne: .white, colorTwo: .white)
            loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    
    private func userFinishedLoggingIn() {
        UserDefaults.standard.setIsLogedIn(value: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentDailyFood" {
            let destVC = segue.destination as! DailyFoodController
//            destVC.token = sender as! GTMFetcherAuthorizationProtocol
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        userFinishedLoggingIn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func buttonTapped() {
        performSegue(withIdentifier: "presentDailyFood", sender: token)
        userFinishedLoggingIn()
    }
    
}

