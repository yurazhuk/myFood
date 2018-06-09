//
//  StartUsingApplicationCell.swift
//  MyFood
//
//  Created by yurii zhuk on 6/9/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
   
   
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .orange
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loginButton)
        
        
        _ = loginButton.anchor(bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 80, leftConstant: 50, bottomConstant: 0, rightConstant: 50, widthConstant: 0, heightConstant: 80)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
