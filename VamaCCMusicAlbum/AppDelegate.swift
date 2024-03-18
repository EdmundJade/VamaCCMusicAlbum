//
//  AppDelegate.swift
//  VamaCCMusicAlbum
//
//  Created by Heng Gek Leng Edmund on 18/3/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?
    var coordinator: MainCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navController = UINavigationController()

        // send that into our coordinator so that it can display view controllers
        coordinator = MainCoordinator(navigationController: navController)
        guard let c = coordinator else {
            fatalError("no coordinator")
            return false
        }
            // tell the coordinator to take over control
        c.start()
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let w = window else {
            return false
        }
        w.rootViewController = navController
        w.makeKeyAndVisible()
        return true
    }

}

