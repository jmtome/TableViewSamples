//
//  Item.swift
//  LootLogger
//
//  Created by Juan Manuel Tome on 20/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit



class Item: Equatable, Codable {
    
    enum Category {
        case electronics
        case clothing
        case book
        case other
    }

    var category = Category.other
    
    enum CodingKeys: String, CodingKey {
        case name
        case valueInDollars
        case serialNumber
        case dateCreated
        case isFavorite
        case category
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(valueInDollars, forKey: .valueInDollars)
        try container.encode(serialNumber, forKey: .serialNumber)
        try container.encode(dateCreated, forKey: .dateCreated)
        try container.encode(isFavorite, forKey: .isFavorite)
        
        switch category {
            case .electronics:
                try container.encode("electronics", forKey: .category)
            case .clothing:
                try container.encode("clothing", forKey: .category)
            case .book:
                try container.encode("book", forKey: .category)
            case .other:
                try container.encode("other", forKey: .category)
        }
        
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.valueInDollars = try container.decode(Int.self, forKey: .valueInDollars)
        self.serialNumber = try container.decode(String?.self, forKey: .serialNumber)
        self.dateCreated = try container.decode(Date.self, forKey: .dateCreated)
        self.isFavorite = try container.decode(Bool.self, forKey: .isFavorite)
        
        let categoryString = try container.decode(String.self, forKey: .category)
        switch categoryString {
        case "electronics":
            self.category = .electronics
        case "clothing":
            self.category = .clothing
        case "book":
            self.category = .book
        case "other":
            self.category = .other
        default:
            self.category = .other
        }
    }
    
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.valueInDollars == rhs.valueInDollars && lhs.serialNumber == rhs.serialNumber && lhs.dateCreated == rhs.dateCreated
    }
    
    var name: String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: Date
    var isFavorite: Bool
    
    init(name: String, valueInDollars: Int, serialNumber: String?, isFavorite: Bool?, date: Date?) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = date ?? Date()
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
            
            self.init(name: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber, isFavorite: isFavorite, date: nil)
            
        } else {
            self.init(name: "", valueInDollars: 0, serialNumber: nil, isFavorite: nil, date: nil)
        }
    }

}
