//
//  Loader.swift
//  RickNMorty
//
//  Created by Алексей Папин on 13.11.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import Alamofire

// MARK: - Loader
class Loader {
    let networkService: NetworkServiceProtocol = NetworkService.shared
    
    public var isLoading: Bool { return self.networkService.isLoading }
    private var currentPage = 1
    private var code: String

    init(code: String) {
        self.code = code
    }
    
    func getPoints(completion: @escaping ((Result<[Point], Error>) -> Void)) {
        networkService.getPoints(code: code,
                                 page: currentPage,
                                 completion: {
                                    [weak self] result in
                                    
                                    switch result {
                                    case let .success(page):
                                        completion(.success(page.data))
                                        self?.currentPage += 1
                                        
                                    case let .failure(error):
                                        if let afError = error as? AFError {
                                            print(afError)
                                        }
                                        completion(.failure(error))
                                    }
                                 })
    }
}
