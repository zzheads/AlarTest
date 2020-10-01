//
//  LoginViewModel.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit

class LoginViewModel: BaseViewModel {
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    
    func login(username: String?, password: String?) {
        guard let username = username, let password = password else {
            return
        }
        networkService.getCode(username: username, password: password, completion: {
            [weak self] result in
            
            switch result {
            case let .success(code):
                self?.show?("Success", "Code is: \(code)")
                
            case let .failure(error):
                self?.show?("Error", error.localizedDescription)
            }
        })
    }
}
