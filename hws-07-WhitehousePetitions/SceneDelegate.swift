//
//  SceneDelegate.swift
//  hws-07-WhitehousePetitions
//
//  Created by Philip Hayes on 6/22/20.
//  Copyright © 2020 PhilipHayes. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
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
        
        /* add a second view controller to the tab bar:
         1. reate a duplicate ViewController wrapped inside a navigation controller,
         2. give it a new tab bar item to distinguish it from the existing tab,
         3. add it to the list of visible tabs.
         This uses the same class for both tabs without having a duplicate view controller in the storyboard.
         */
        
        // root view controller is embedded in a navigation controller which is embedded in a tab bar controller
        if let tabBarController = window?.rootViewController as? UITabBarController {
            
            // get a reference to the main storyboard file. bundle: nil implies current app bundle
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            // create the new view controller and pass in the storyboard id of the navigation controller
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            
            // create a tab bar item for the new view controller with a "Top Rated" icon and a tag
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            
            // add new view controller to tab bar controller vc array so it appears in the tab bar
            tabBarController.viewControllers?.append(vc)
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

