//
//  AppDelegate.swift
//  Atia Hospital
//
//  Created by Kerim Njuhovic on 10/02/2020.
//  Copyright © 2020 Kerim Njuhovic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// Represents collection of all services and third party libraries,
    /// which requires some sort of setup before the app is launched.
    public fileprivate (set) var services: [UIApplicationDelegate] = [
          AppNavigationService(),
          FirebaseService()
      ]

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Call the available services and make initial setup
        for service in self.services {
            _ = service.application?(application, didFinishLaunchingWithOptions: launchOptions)
        }
        AppAppearance.setupAppearance()
        
        return true
    }

    // MARK: - UISceneSession Lifecycle -

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

}
