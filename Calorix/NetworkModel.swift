//
//  NetworkModel.swift
//  Calorix
//
//  Created by KoichiNishide on 2014/09/14.
//  Copyright (c) 2014年 KoichiNishide. All rights reserved.
//

class NetworkModel : NSObject {
    func asyncLoadAllFoods () {
        var query : PFQuery = PFQuery(className: "Food")
        query.findObjectsInBackgroundWithBlock({(objects : [AnyObject]!, error: NSError!) in
            if (error != nil) {
                NSLog("error " + error.localizedDescription)
            }
            else {
                NSLog("objects %@", objects as NSArray)
            }
        })
    }
}
