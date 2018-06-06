//
//  DailyFoodScreenController.swift
//  MyFood
//
//  Created by yurii zhuk on 6/6/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import Foundation
import UIKit

class DailyFoodScreenController: UIViewController {
    static var newController: DailyFoodScreenController {
        return Bundle.main.loadNibNamed("DailyFoodScreenController.xib", owner: self, options: nil)!.first! as! DailyFoodScreenController
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
    }
}
