//
//  ParseBridgeModel.swift
//  Calorix
//
//  Created by KoichiNishide on 2014/09/14.
//  Copyright (c) 2014年 KoichiNishide. All rights reserved.
//

class ParseBridgeModel {
    weak var delegate :ParseBridgeDelegate? = nil
    let mealClassName = "Meal"
    let foodsKey = "foods"
    let foodClassName = "Food"
    let nameKey = "name"
    let calorieKey = "calorie"
    
    func asyncLoadAllMeals () {
        var query: PFQuery = PFQuery(className: foodClassName)
        query.findObjectsInBackgroundWithBlock({(foods: [AnyObject]!, error: NSError!) in
            if (error != nil) {
                NSLog("error " + error.localizedDescription)
                return
            }
            var loadedFoods:[Food] = []
            for food in foods {
                var name = food.objectForKey(self.nameKey) as String?
                var calorie = food.objectForKey(self.calorieKey) as Int?
                var loadedFood = Food(name: name!, calorie: calorie!)
                loadedFoods.append(loadedFood)
            }
            self.delegate?.loadedAllFood(loadedFoods)
        })
    }
}

protocol ParseBridgeDelegate : class {
    func loadedAllFood(foods : [Food]) -> ()
}

