//
//  NameVC.swift
//  MyFood
//
//  Created by yurii zhuk on 6/8/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//


import GoogleAPIClientForREST
import UIKit

class NameVC: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var token: GTMFetcherAuthorizationProtocol!
    private var userIsLogedIn: Bool{
        return UserDefaults.standard.isLoggedIn()
    }
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        userFinishedLoggingIn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        if userIsLogedIn {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "presentDailyFood", sender: self.token)
            }
        } else {
            backgroundImage.image = UIImage(named: "background")
        view.addSubview(backgroundImage)
            
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        button.center = view.center
        button.backgroundColor = .black
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        }
    }
    
    
    private func userFinishedLoggingIn() {
        UserDefaults.standard.setIsLogedIn(value: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentDailyFood" {
            let destVC = segue.destination as! DailyFoodController
            destVC.token = sender as! GTMFetcherAuthorizationProtocol
        }
    }
    
    @objc func buttonTapped() {
        performSegue(withIdentifier: "presentDailyFood", sender: token)
        userFinishedLoggingIn()
    }
    
}

