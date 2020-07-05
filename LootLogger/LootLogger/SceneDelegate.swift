//
//  SceneDelegate.swift
//  LootLogger
//
//  Created by Juan Manuel Tome on 20/06/2020.
//  Copyright © 2020 Juan Manuel Tome. All rights reserved.
//

import UIKit

var theCount = 1
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    
    let itemStore = ItemStore()
    let imageStore = ImageStore()
    let favStore = ItemStore()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        window?.tintColor = UIColor(named: "Brand Accent Color")
        
        //let itemsController = window!.rootViewController as! ItemsViewController
        // this commented code is from before UINavigationController
        
        let navController = window!.rootViewController as! UINavigationController
        let itemsController = navController.topViewController as! ItemsViewController
        itemsController.itemStore = itemStore
        itemsController.favStore = favStore
        itemsController.imageStore = imageStore
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        try? itemStore.saveChanges()
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
//
//        let success = itemStore.saveChanges()
//        if success {
//            print(" saved")
//        } else {
//            print(" unsaved")
//        }
        //el archivo del libro lo modifica aca, pero no dice nada el libro, me pregunto porque,
        // el archivo del libro tampoco usa .atomic cuando guarda pero en el libro dice q hay q usar
    
    }


}

