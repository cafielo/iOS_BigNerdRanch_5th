//
//  Item.swift
//  Homepwner
//
//  Created by Joonwon Lee on 7/31/16.
//  Copyright © 2016 Joonwon Lee. All rights reserved.
//

import UIKit

class Item: NSObject {
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    let dateCreated: NSDate
    let itemKey: String
    
    init(name: String, serialNumber: String?, valueInDollars:Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = NSDate()
        self.itemKey = NSUUID().UUIDString
        super.init()
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            var idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = nouns[Int(idx)]
            
            idx = arc4random_uniform(UInt32(nouns.count))
            let randomNoun = nouns[Int(idx)]
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomwValue = Int(arc4random_uniform(100))
            let randomSerialNumber = NSUUID().UUIDString.componentsSeparatedByString("-").first!
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomwValue)
            
        } else {
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }

}
