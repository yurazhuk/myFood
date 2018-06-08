//
//  DailyFoodCell.swift
//  MyFood
//
//  Created by yurii zhuk on 6/7/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import UIKit

class Meal {
    let mealName: String
    let portions: Int
    let descriprion: String
    let image:  UIImage
    
    init(mealName: String, portions: Int, descriprion: String, image: UIImage) {
        self.mealName = mealName
        self.portions = portions
        self.descriprion = descriprion
        self.image = image
    }
}
