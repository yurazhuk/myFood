//
//  PopOverViewController.swift
//  MyFood
//
//  Created by yurii zhuk on 6/8/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import UIKit

class PopOverViewController : UIViewController{

    var meal: Meal!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextView!
    @IBAction func closePopOver(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        imageView.image = meal.image
        textField.text = meal.descriprion
        
    }
}
