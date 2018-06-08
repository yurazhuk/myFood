//
//  DailyFoodCell.swift
//  MyFood
//
//  Created by yurii zhuk on 6/8/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import UIKit

class DailyFoodCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var mealName: UILabel!
    @IBOutlet weak var mealCount: UILabel!
    
    func setMeal(meal: Meal) {
//        cellImageView.image = UIImage(named: "Page1")
        mealName.text = meal.mealName
        mealCount.text = meal.descriprion
    }
}
