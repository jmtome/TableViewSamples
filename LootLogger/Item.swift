//
//  Item.swift
//  LootLogger
//
//  Created by Juan Manuel Tome on 20/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.valueInDollars == rhs.valueInDollars && lhs.serialNumber == rhs.serialNumber && lhs.dateCreated == rhs.dateCreated
    }
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: Date
    var isFavorite: Bool
    
    init(name: String, valueInDollars: Int, serialNumber: String?, isFavorite: Bool?) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.isFavorite = isFavorite ?? false
    }
    
    convenience init(random: Bool = false) {
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            let randomAdjective = adjectives.randomElement()!
            let randomNoun = nouns.randomElement()!
            
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int.random(in: 0..<100)
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            let isFavorite = Bool.random()
            
            self.init(name: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber, isFavorite: isFavorite)
            
        } else {
            self.init(name: "", valueInDollars: 0, serialNumber: nil, isFavorite: nil)
        }
    }

}
