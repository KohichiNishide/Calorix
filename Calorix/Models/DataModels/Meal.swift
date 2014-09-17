//
//  Meal.swift
//  Calorix
//
//  Created by KoichiNishide on 2014/09/17.
//  Copyright (c) 2014年 KoichiNishide. All rights reserved.
//

class Meal {
    var takenAt: NSDate
    var foods: [Food]
    
    init(takenAt: NSDate, foods: [Food]) {
        self.takenAt = takenAt
        self.foods = foods
    }
}
