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
    lazy var loginVM = LoginViewModel()
    lazy var loginVC = LoginViewController(viewModel: loginVM)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        loginVC.loadViewIfNeeded()
        
        self.window?.rootViewController = loginVC
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
}

