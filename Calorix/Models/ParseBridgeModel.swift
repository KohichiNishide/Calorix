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
    
    var loadedMeals: [PFObject] = []
    
    func asyncLoadAllMeals () {
        var query: PFQuery = PFQuery(className: mealClassName)
        query.findObjectsInBackgroundWithBlock({(meals: [AnyObject]!, error: NSError!) in
            if (error != nil) {
                NSLog("error " + error.localizedDescription)
                return
            }
            self.loadedMeals = meals as [PFObject]
            self.asyncLoadAllFoods()
        })
    }
    
    func asyncLoadAllFoods () {
        var reloadedFoods:[Food] = []
        for meal in loadedMeals {
            var relation: PFRelation = meal.relationForKey(self.foodsKey)
            var foodsQuery: PFQuery = relation.query()
            foodsQuery.findObjectsInBackgroundWithBlock({(foods: [AnyObject]!, error: NSError!) in
                if (error != nil) {
                    NSLog("error " + error.localizedDescription)
                    return
                }
                for food in foods {
                    var name = food.objectForKey(self.nameKey) as String?
                    var calorie = food.objectForKey(self.calorieKey) as Int?
                    var reloadedFood = Food(name: name!, calorie: calorie!)
                    reloadedFoods.append(reloadedFood)
                }
                //TODO: get image file
                var takenAt: NSDate = meal.objectForKey("takenAt") as NSDate!
                self.delegate?.loadedAllFoodsByMealUnit(Meal(takenAt: takenAt, foods: reloadedFoods))
            })
        }
    }
}

protocol ParseBridgeDelegate : class {
    func loadedAllFoodsByMealUnit(meal: Meal) -> ()
}

