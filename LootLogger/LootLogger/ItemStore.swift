//
//  ItemStore.swift
//  LootLogger
//
//  Created by Juan Manuel Tome on 20/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

class ItemStore {
    var allItems: [Item] = [Item]()
    let itemArchiveURL: URL = {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        return documentDirectory.appendingPathComponent("items.plist")
    }()
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(_ item: Item) {
        if let index = allItems.firstIndex(of: item) {
            allItems.remove(at: index)
        }
    }
    func moveItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
        
    }
    @objc func saveChanges() throws {
        print("Saving items to: \(itemArchiveURL)")
        let encoder = PropertyListEncoder()
        let data = try encoder.encode(allItems)
        try data.write(to: itemArchiveURL, options: [.atomic])
        
        print("Items saved successfully")
        
    }
    
    //como saveChanges ahora Throws, no necesita catchear el throws del try del encoder, porque lo propaga al proximo bloque que llame a la funcion que hace throw, que es saveChanges
    //se supone que quien llame a saveChanges deberia encargarse del throw del encoder
    //tambien podria hacer a savechanges encargarse del throw de encoder y hacer throw de otro error que quisiera
    
    
    //la funcion de abajo era la anterior, que tenia que catchear el throw
    /*
     @objc func saveChanges() -> Bool {
     do {
         let encoder = PropertyListEncoder()
         let data = try encoder.encode(allItems)
         try data.write(to: itemArchiveURL, options: [.atomic])
         
         print("Items saved successfully")
         return true
     } catch let encodingError {
         print("Error encoding allitems: \(encodingError)")
         return false
     }
     
     */
    
    init() {
        //esto esta mal, pero sino, cuando declaro el favstore intenta guardar y leer y asignar notificationCenterObservers y me rompe todo
        //tengo que hacerlo bien
        if theCount == 1 {
            do {
                let data = try Data(contentsOf: itemArchiveURL)
                let unarchiver = PropertyListDecoder()
                let items = try unarchiver.decode([Item].self, from: data)
                allItems = items
                print("reading data from: \(itemArchiveURL)")
                theCount = 2
            } catch {
                print("Error reading in saved items \(error)")
            }
            let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(saveChanges), name: UIScene.didEnterBackgroundNotification, object: nil)
            
        }
        
        
        
    }
//    init() {
//        for _ in 0..<5 {
//            createItem()
//        }
//    }
}

//TODO: - Gold Challenge of persistance
/*
 “Gold Challenge: Support Multiple Windows
 You can enable multiple window support within an application by opening the project settings and, under Deployment Info, checking the Supports multiple windows checkbox. While this small change will allow you to have multiple instances of the LootLogger interface open, each of those instances will have its own instance of ItemStore and therefore its own items. This is not what you would like.

 For this challenge, update LootLogger to support multiple windows and share its ItemStore across scenes. You will want a way for one scene to be updated in response to an event in another scene. For example, if a user adds a new Item in one scene, it should also appear in the items list for any other scene.”

 */
