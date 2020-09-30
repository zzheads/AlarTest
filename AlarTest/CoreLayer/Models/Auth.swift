//
//  Auth.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import Foundation

class Auth: Codable {    
    var status: Status
    var code: String
}

extension Auth {
    static func code(username: String, password: String) -> Resource<Auth> {
        return Resource(endpoint: .auth, method: .get, parameters: ["username": username, "password": password])
    }
}
