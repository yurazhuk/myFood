//
//  UIimageView + Load.swift
//  MyFood
//
//  Created by yurii zhuk on 6/9/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
