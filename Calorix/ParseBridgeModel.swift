//
//  ParseBridgeModel.swift
//  Calorix
//
//  Created by KoichiNishide on 2014/09/14.
//  Copyright (c) 2014年 KoichiNishide. All rights reserved.
//

class ParseBridgeModel {
    weak var delegate :ParseBridgeDelegate? = nil
    let foodClassName = "Food"
    let nameKey = "name"
    let calorieKey = "calorie"
    
    func asyncLoadAllFoods () {
        var query: PFQuery = PFQuery(className: foodClassName)
        query.findObjectsInBackgroundWithBlock({(objects: [AnyObject]!, error: NSError!) in
            if (error != nil) {
                NSLog("error " + error.localizedDescription)
            }
            else {
                var foods = [Food]()
                for parseObject in objects {
                    var name = parseObject.objectForKey(self.nameKey) as String?
                    var calorie = parseObject.objectForKey(self.calorieKey) as Int?
                    var food = Food(name: name!, calorie: calorie!)
                    foods.append(food)
                }
                self.delegate?.loadedAllFood(foods)
            }
        })
    }
}

protocol ParseBridgeDelegate : class {
    func loadedAllFood(foods : [Food]) -> ()
}

