//
//  UserDefaults + isLogedIn.swift
//  MyFood
//
//  Created by yurii zhuk on 6/9/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum userDefaultsKeys: String {
        case isLoggedIn
    }
    
    func setIsLogedIn(value: Bool) {
        set(value, forKey: userDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: userDefaultsKeys.isLoggedIn.rawValue)
    }
    
}
