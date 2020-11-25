//
//  AppDelegate.swift
//  iTechArtApp
//
//  Created by Tsimafei Zykau on 11/23/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let navController = UINavigationController()
        navController.addChild(ListViewController())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }


}

