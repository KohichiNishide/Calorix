//
//  ParseBridgeModel.swift
//  Calorix
//
//  Created by KoichiNishide on 2014/09/14.
//  Copyright (c) 2014年 KoichiNishide. All rights reserved.
//

protocol ParseBridgeDelegate : class {
    func loadedAllFood(foods : NSArray) -> ()
}

class ParseBridgeModel : NSObject {
    weak var delegate :ParseBridgeDelegate? = nil
    
    //var foods = [Food]()
    var foods : NSArray = []
    func asyncLoadAllFoods () {
        var query : PFQuery = PFQuery(className: "Food")
        query.findObjectsInBackgroundWithBlock({(objects : [AnyObject]!, error: NSError!) in
            if (error != nil) {
                NSLog("error " + error.localizedDescription)
            }
            else {
                self.foods = objects
                NSLog("foods %@", self.foods as NSArray)
                self.delegate?.loadedAllFood(self.foods)
            }
        })
    }
}

