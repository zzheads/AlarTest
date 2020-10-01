//
//  Page.swift
//  RickNMorty
//
//  Created by Алексей Папин on 13.11.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import Foundation

// MARK: - Page
class Page<T: Codable>: Codable {
    var status: Status
    var page: Int
    var data: T
}
