//
//  NetworkService.swift
//  RickNMorty
//
//  Created by Алексей Папин on 13.11.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import Foundation

// MARK: - NetworkServiceProtocol
protocol NetworkServiceProtocol {
    func getCode(username: String, password: String, completion: @escaping ((Result<String, Error>) -> Void))
    func getPoints(code: String, page: Int, completion: @escaping ((Result<Page<[Point]>, Error>) -> Void))
    var isLoading: Bool { get }
}

// MARK: - NetworkService
class NetworkService {
    static let shared = NetworkService(webService: WebService.shared)
    
    let webService: WebServiceProtocol
    var isLoading: Bool = false
    
    private init(webService: WebService) {
        self.webService = webService
    }
}

// MARK: - NetworkServiceProtocol
extension NetworkService: NetworkServiceProtocol {
    func getCode(username: String, password: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        webService.fetch(resource: Auth.code(username: username, password: password),
                         completion: {
                            result in
                            
                            switch result {
                            case let .success(auth):
                                switch auth.status {
                                case .success:
                                    completion(.success(auth.code))
                                case .failure:
                                    completion(.failure(AppError.badCredentials))
                                }
                                
                            case let .failure(error):
                                completion(.failure(error))
                            }
                         })
    }
    
    func getPoints(code: String, page: Int, completion: @escaping ((Result<Page<[Point]>, Error>) -> Void)) {
        webService.fetch(resource: Point.page(number: page, code: code), completion: completion)
    }
}
