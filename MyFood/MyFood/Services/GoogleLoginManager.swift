//
//  GoogleLoginManager.swift
//  MyFood
//
//  Created by yurii zhuk on 6/6/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST

protocol GoogleLoginManagerDelegate: class {
    func didFailToLogin(with error: Error)
    func didLoginSuccessfully(with authorizer: GTMFetcherAuthorizationProtocol)
}

class GoogleLoginManager: NSObject, GIDSignInDelegate {
    
    override init() {
        super.init()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().signInSilently()
    }
    
    enum LoginErrors: Error {
        case failedToGetAuthorizer
        
        var localizedDescription: String {
            switch self {
            case .failedToGetAuthorizer:
                // NOTE: - Probably change to nslocalizedstring for lcalization purposes
                return "Failed to get authorizer"
            }
        }
    }
    
    weak var delegate: GoogleLoginManagerDelegate?
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            delegate?.didFailToLogin(with: error)
        } else {
            if let authorizer = user.authentication.fetcherAuthorizer() {
                delegate?.didLoginSuccessfully(with: authorizer)
            } else {
                delegate?.didFailToLogin(with: LoginErrors.failedToGetAuthorizer)
            }
        }
    }
}
