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
    
    private var logoImageView: UIImageView!
    private var loginButton: UIButton!
    private var textField: UITextField!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        backgroundImage.image = UIImage(named: "background")
        view.addSubview(backgroundImage)
        setuplogoImageView()
        setupNameField()
        setupLoginButton()
        textField.becomeFirstResponder()
    }
    
    override func viewWillLayoutSubviews() {
        logoImageView.layer.cornerRadius = logoImageView.frame.size.width/2
        logoImageView.clipsToBounds = true
        
        logoImageView.layer.borderColor = UIColor.white.cgColor
        logoImageView.layer.borderWidth = 5.0
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if let userName = textField.text {
        UserDefaults.standard.setName(name: userName)
        } else {
            UserDefaults.standard.setName(name: "\(GIDSignIn.sharedInstance().currentUser.profile.name) \(GIDSignIn.sharedInstance().currentUser.profile.familyName)")
        }
    }
    
    func setuplogoImageView() {
        logoImageView = UIImageView()
        
        if let url = GIDSignIn.sharedInstance().currentUser.profile.imageURL(withDimension: 150) {
            logoImageView.load(url: url)
        } else {
            logoImageView.image = #imageLiteral(resourceName: "logo")
        }
        
        view.addSubview(logoImageView)
        
        _ = logoImageView.anchor(view.centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupNameField() {
        textField = LeftPaddedTextField()
        textField.placeholder = "Leave blank to use Google one"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        textField.becomeFirstResponder()
        view.addSubview(textField)
        
        _ = textField.anchor(logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
    }
    
    func setupLoginButton() {
        loginButton = UIButton ()
        loginButton.backgroundColor = .blue
        loginButton.setTitle("Log In", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        
        loginButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        _ = loginButton.anchor(textField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 16, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 0, heightConstant: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    private func userFinishedLoggingIn() {
        UserDefaults.standard.setIsLogedIn(value: true)
    }
    
    @objc func buttonTapped() {
        performSegue(withIdentifier: "presentDailyFood", sender: self)
        userFinishedLoggingIn()
    }
}

