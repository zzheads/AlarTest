//
//  ScreenFactory.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit

// MARK: - ScreenFactory
class ScreenFactory {
    private struct Constants {
        static let barTintColor: UIColor = .lightGray
    }
    
    static let shared: ScreenFactory = .init()
    
    private init() {
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 13), .foregroundColor: Constants.barTintColor], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 13), .foregroundColor: Constants.barTintColor], for: .highlighted)
    }
    
    func mainScreen() -> UINavigationController {
        let controller = UINavigationController(rootViewController: loginViewController())
        controller.navigationBar.barStyle = .black
        controller.navigationBar.isTranslucent = true
        controller.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15)]
        controller.navigationBar.tintColor = Constants.barTintColor
        return controller
    }
    
    func loginViewController() -> LoginViewController {
        return LoginViewController(viewModel: LoginViewModel())
    }
    
    func pointsViewController(code: String) -> PointsViewController {
        return PointsViewController(viewModel: PointsViewModel(code: code))
    }
    
    func pointViewController(point: Point) -> PointViewController {
        return PointViewController(viewModel: PointViewModel(point: point))
    }
}
