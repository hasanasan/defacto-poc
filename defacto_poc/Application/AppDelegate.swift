//
//  AppDelegate.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Internal -

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
        -> Bool
    {
        // Override point for customization after application launch.
        services.allSatisfy { service -> Bool in
            service.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? true
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options _: UIScene.ConnectionOptions)
        -> UISceneConfiguration
    {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_: UIApplication, didDiscardSceneSessions _: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after
        // application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Private -

    private lazy var services: [UIApplicationDelegate] = [LoggingService()]
}
