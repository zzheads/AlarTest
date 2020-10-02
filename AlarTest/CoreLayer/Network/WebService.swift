//
//  WebService.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import Alamofire

// MARK: - WebServiceProtocol
protocol WebServiceProtocol {
    func fetch<T: Codable>(resource: Resource<T>, completion: @escaping ((Swift.Result<T, Error>) -> Void))
    @discardableResult
    func download(url: URL, completion: @escaping ((Result<Data, AFError>) -> Void)) -> DataRequest
}

// MARK: - WebService
final class WebService: WebServiceProtocol {
    static let shared = WebService()
    
    private init() {
    }
    
    func fetch<T: Codable>(resource: Resource<T>, completion: @escaping ((Swift.Result<T, Error>) -> Void)) {
            resource.request.responseJSON { response in
                switch response.result {
                case .success:
                    guard let data = response.data else {
                        completion(.failure(AppError.serialization(message: "Response data is nil")))
                        return
                    }
                    do {
                        let object = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(object))
                    } catch {
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    @discardableResult
    func download(url: URL, completion: @escaping ((Result<Data, AFError>) -> Void)) -> DataRequest {
        return AF.request(url).responseData(completionHandler: { completion($0.result) })
    }
}
