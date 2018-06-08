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
    private var input = [[String]]()
    private(set) var workerMeal = [String]()  
    
    init(with data: [[String]]) {
        self.input = data
        formDailyMenu()
    }
    
    private func formDailyMenu() {
        input.removeFirst() // removing unnecessary fields
        let menu = input.removeFirst() // geting menu items
        
        for workerRequests in input {
            if workerRequests[0] == name {
                print(workerRequests)
                for item in 1..<workerRequests.count {
                    if !workerRequests[item].isEmpty {
                        workerMeal.append(menu[item])
                    }
                }
            }
        }
    }
    
}
