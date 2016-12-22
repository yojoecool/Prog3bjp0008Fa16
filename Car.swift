//
//  Car.swift
//  test
//
//  Created by Bridges Penn on 11/16/16.
//  Copyright © 2016 Bridges Penn. All rights reserved.
//

import UIKit

class Car: NSObject, NSCoding {
    var Year: Int
    var Make: String
    var Model: String
    var Condition: Int
    var Options: String
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("cars")
    
    struct propertyKey {
        static let yearKey = "Year"
        static let makeKey = "Make"
        static let modelKey = "Model"
        static let conditionKey = "Condition"
        static let optionsKey = "Options"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(Year, forKey: propertyKey.yearKey)
        aCoder.encodeObject(Make, forKey: propertyKey.makeKey)
        aCoder.encodeObject(Model, forKey: propertyKey.modelKey)
        aCoder.encodeInteger(Condition, forKey: propertyKey.conditionKey)
        aCoder.encodeObject(Options, forKey: propertyKey.optionsKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let year = aDecoder.decodeIntegerForKey(propertyKey.yearKey)
        let make = aDecoder.decodeObjectForKey(propertyKey.makeKey) as! String
        let model = aDecoder.decodeObjectForKey(propertyKey.modelKey) as! String
        let condition = aDecoder.decodeIntegerForKey(propertyKey.conditionKey)
        let options = aDecoder.decodeObjectForKey(propertyKey.optionsKey) as! String
        
        self.init(year: year, make: make, model: model, cond: condition, options: options)
    }
    
    /*
    init() {
        self.Year = 2016
        self.Make = "New Car"
        self.Model = "New Model"
        self.Condition = 5
        self.Options = ""
    }
     */
    
    init(year: Int, make: String, model: String, cond: Int, options: String) {
        self.Year = year
        self.Make = make
        self.Model = model
        self.Condition = cond
        self.Options = options
        
        super.init()
    }
}
