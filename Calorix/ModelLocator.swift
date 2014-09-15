//
//  ModelLocator.swift
//  Calorix
//
//  Created by KoichiNishide on 2014/09/14.
//  Copyright (c) 2014年 KoichiNishide. All rights reserved.
//

class ModelLocator : NSObject {
    class var sharedInstance : ModelLocator {
        struct Singleton {
            static let instance : ModelLocator = ModelLocator()
        }
        return Singleton.instance
    }
    
    var parseBridgeModel : ParseBridgeModel = ParseBridgeModel()
}
