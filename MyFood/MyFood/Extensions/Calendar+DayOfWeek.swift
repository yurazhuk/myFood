//
//  Calendar+DayOfWeek.swift
//  MyFood
//
//  Created by yurii zhuk on 6/6/18.
//  Copyright © 2018 yurii zhuk. All rights reserved.
//

import Foundation

extension Calendar {
    static var currentDayOfWeek: String {
        let currentDate = Date()
        let component = Calendar.current.component(.weekday, from: currentDate)
        switch component {
        case 1:
            return "Понедельник "
        case 2:
            return "Понедельник "
        case 3:
            return "Вторник"
        case 4:
            return "Среда "
        case 5:
            return "Четверг "
        case 6:
            return "Пятница "
        case 7:
            return "Понедельник "
        default:
            return "Unknown"
        }
    }
}
