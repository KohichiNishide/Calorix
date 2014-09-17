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
        var query: PFQuery = PFQuery(className: mealClassName)
        query.findObjectsInBackgroundWithBlock({(meals: [AnyObject]!, error: NSError!) in
            if (error != nil) {
                NSLog("error " + error.localizedDescription)
                return
            }
            for meal in meals {
                self.asyncLoadFoods (meal as PFObject)
            }
        })
    }
    
    func asyncLoadFoods (meal: PFObject) {
        var relation: PFRelation = meal.relationForKey(self.foodsKey)
        var foodsQuery: PFQuery = relation.query()
        foodsQuery.findObjectsInBackgroundWithBlock({(foods: [AnyObject]!, error: NSError!) in
            if (error != nil) {
                NSLog("error " + error.localizedDescription)
                return
            }
            var reloadedFoods = [Food]()
            for food in foods {
                var name = food.objectForKey(self.nameKey) as String?
                var calorie = food.objectForKey(self.calorieKey) as Int?
                var reloadedFood = Food(name: name!, calorie: calorie!)
                reloadedFoods.append(reloadedFood)
            }
            self.delegate?.loadedAllFood(reloadedFoods)
        })
    }
}

protocol ParseBridgeDelegate : class {
    func loadedAllFood(foods : [Food]) -> ()
}

