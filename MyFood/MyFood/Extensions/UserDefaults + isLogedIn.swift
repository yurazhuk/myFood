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
        case Name
    }
    
    func setName(name:String) {
        set(name, forKey: userDefaultsKeys.Name.rawValue)
        setIsLogedIn(value: true)
        synchronize()
    }
    
    func getName() -> String? {
        return string(forKey: userDefaultsKeys.Name.rawValue)
    }
    
    func setIsLogedIn(value: Bool) {
        set(value, forKey: userDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func isLoggedIn() -> Bool {
        return bool(forKey: userDefaultsKeys.isLoggedIn.rawValue)
    }
}
