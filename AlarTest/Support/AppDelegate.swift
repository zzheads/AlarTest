//
//  AppDelegate.swift
//  AlarTest
//
//  Created by Алексей Папин on 30.09.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private let screenFactory: ScreenFactory = .shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = screenFactory.mainScreen()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

extension AppDelegate {
    static var currentDelegate: AppDelegate {
        return currenctApplication.delegate as! AppDelegate
    }
    
    static var currentWindow: UIWindow {
        return currentDelegate.window!
    }
    
    static var currenctApplication: UIApplication {
        return UIApplication.shared
    }
    
    static func push(_ controller: UIViewController) {
        guard let navigationViewController = currentWindow.rootViewController as? UINavigationController else {
            return
        }
        navigationViewController.pushViewController(controller, animated: true)
    }
}

