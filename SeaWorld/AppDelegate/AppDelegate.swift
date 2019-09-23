//
//  AppDelegate.swift
//  SeaWorld
//
//  Created by Andrey Rodionov on 11/09/2019.
//  Copyright © 2019 Andrey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // setup root view controller
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainScreenVC()
        window?.makeKeyAndVisible()

        return true
    }
}
