//
//  Resource.swift
//  Test
//
//  Created by Алексей Папин on 14.10.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import Alamofire

// MARK: - Endpoint
enum Endpoint: String {
    static let base: String = "https://www.alarstudios.com/test/"
    
    case auth = "auth.cgi"
    case data = "data.cgi"
    
    var path: String {
        return [Endpoint.base, rawValue].joined()
    }
}

// MARK: - Resource
struct Resource<T: Codable> {
    let endpoint    : Endpoint
    let method      : HTTPMethod
    let parameters  : [String: Any]?
    let encoding    : ParameterEncoding
    let headers     : HTTPHeaders?
    
    init(endpoint: Endpoint, method: HTTPMethod, parameters: [String: Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: HTTPHeaders = ["Accept": "application/json"]) {
        self.endpoint = endpoint
        self.method = method
        self.parameters = parameters
        self.encoding = encoding
        self.headers = headers
    }
    
    var url         : URL {
        return URL(string: self.endpoint.path)!
    }
    
    var request     : DataRequest {
        return AF.request(self.url, method: self.method, parameters: self.parameters, encoding: self.encoding, headers: self.headers)
    }    
}
