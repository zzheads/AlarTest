//
//  LoginViewModel.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit

// MARK: - LoginViewModel
class LoginViewModel: BaseViewModel {
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    private let screenFactory: ScreenFactory = .shared
    
    let title = "Логин"
    
    func login(username: String?, password: String?) {
        guard let username = username, let password = password, !networkService.isLoading else {
            return
        }
        networkService.getCode(username: username, password: password, completion: {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case let .success(code):
                let controller = self.screenFactory.pointsViewController(code: code)
                self.showController?(controller)
                
            case let .failure(error):
                if case .badCredentials = error as? AppError {
                    self.show?("Ошибка", "Не верные логин/пароль")
                } else {
                    self.show?("Ошибка", error.localizedDescription)
                }
            }
        })
    }
}
