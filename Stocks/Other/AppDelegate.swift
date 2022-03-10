//
//  AppDelegate.swift
//  Stocks
//
//  Created by Yaroslav on 5.01.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    
    ///  Gets called when app launches
    /// - Parameters:
    ///   - application: App instance
    ///   - launchOptions:  Launch properties
    /// - Returns: Bool for succes or failure
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}

