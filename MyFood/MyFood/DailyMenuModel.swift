//
//  MenuController.swift
//  MyFood
//
//  Created by yurii zhuk on 6/5/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import Foundation

class DailyMenuModel {
    
    private let name = "Боб Коузи"
    private var menuItems = [[String]]()
    
    init(with data: [[String]]) {
        self.menuItems = data
        formDailyMenu()
    }
    
    func getMenuItemsString() -> String {
        var majorsString = "Name, Major:\n"
        for row in menuItems {
            let name = row[0]
            let major = row[1]
            
            majorsString += "\(name), \(major)\n"
        }
        return majorsString
    }
    
    private func formDailyMenu() {
        menuItems.removeFirst() // removing unnecessary fields
        let menu = menuItems.removeFirst() // geting menu items
        
        for workerRequests in menuItems {
            if workerRequests[0] == name {
                print(workerRequests)
                for item in 1..<workerRequests.count {
                    if !workerRequests[item].isEmpty {
                        print(menu[item])
                    }
                }
            }
        }
    }
    
}
