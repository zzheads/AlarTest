//
//  Status.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import Foundation

// MARK: - Status
enum Status: String, Codable {
    case success = "ok"
    case failure = "error"
}
