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
    
    private var sheetsDataProvider: GTMFetcherAuthorizationProtocol!
    
    init(_ authorizer: GTMFetcherAuthorizationProtocol) {
        super.init(nibName: nil, bundle: nil)
        sheetsDataProvider = authorizer
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
    }
}
