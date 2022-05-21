//
//  AppDelegate.swift
//  RestorauntsApp
//
//  Created by Aliaksei Prokharau on 21.05.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var appEnvironment: AppEnvironment = AppEnvironment.shared

    func application(
            _ application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let appWindow = UIWindow()
        appWindow.rootViewController = appEnvironment.router.getRestaurantListView()
        window = appWindow
        window?.makeKeyAndVisible()
        return true
    }

}

