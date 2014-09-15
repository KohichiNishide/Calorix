//
//  Food.swift
//  Calorix
//
//  Created by KoichiNishide on 2014/09/15.
//  Copyright (c) 2014年 KoichiNishide. All rights reserved.
//

import Foundation
class Food {
    var name : String = ""
    var calorie : Int = 0
    
    init(name: String, calorie: Int) {
        self.name = name
        self.calorie = calorie
    }
}