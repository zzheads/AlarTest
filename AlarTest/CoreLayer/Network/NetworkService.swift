//
//  NetworkService.swift
//  RickNMorty
//
//  Created by Алексей Папин on 13.11.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import UIKit
import Alamofire

// MARK: - NetworkServiceProtocol
protocol NetworkServiceProtocol {
    func getCode(username: String, password: String, completion: @escaping ((Result<String, Error>) -> Void))
    func getPoints(code: String, page: Int, completion: @escaping ((Result<Page<[Point]>, Error>) -> Void))
    @discardableResult func getImage(url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> DataRequest
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
    
    @discardableResult
    func getImage(url: URL, completion: @escaping ((Result<UIImage, Error>) -> Void)) -> DataRequest {
        webService.download(url: url, completion: {
            result in
            
            switch result {
            case let .success(data):
                guard let image = UIImage(data: data) else {
                    completion(.failure(AppError.badData(message: "Bad image data")))
                    return
                }
                completion(.success(image))
                
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
}
