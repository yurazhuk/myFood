//
//  NameVC.swift
//  MyFood
//
//  Created by yurii zhuk on 6/8/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//


import GoogleAPIClientForREST
import GoogleSignIn
import UIKit

class NameVC: UIViewController {
    
    var sheetsDataProvider: GTMFetcherAuthorizationProtocol!
    @IBOutlet weak var enterNameButton: UIButton!
    
//    init(_ authorizer: GTMFetcherAuthorizationProtocol) {
//        super.init(nibName: nil, bundle: nil)
//        sheetsDataProvider = authorizer
//    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        let button = UIButton(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        button.center = view.center
        button.backgroundColor = .black
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "kek" {
            var destVC = segue.destination as! DailyFoodController
            destVC.token = sender as! GTMFetcherAuthorizationProtocol
        }
    }
    
    @objc func buttonTapped() {
    performSegue(withIdentifier: "kek", sender: sheetsDataProvider)
        
    }
    
}

