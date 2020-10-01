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
        let states: [UIControl.State] = [.normal, .highlighted, .selected]
        states.forEach({ UIBarButtonItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 13, weight: .regular), .foregroundColor: Constants.barTintColor], for: $0) })
    }
    
    func mainScreen() -> UINavigationController {
        let controller = UINavigationController(rootViewController: loginViewController())
        controller.navigationBar.barStyle = .black
        controller.navigationBar.barTintColor = Color.primary
        controller.navigationBar.isTranslucent = true
        controller.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15, weight: .medium)]
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
