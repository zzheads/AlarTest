//
//  Character.swift
//  RickNMorty
//
//  Created by Алексей Папин on 13.11.2019.
//  Copyright © 2019 Алексей Папин. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit
import Alamofire

//{
//    "id": "KMTH",
//    "name": "THE FLORIDA KEYS MARATHON",
//    "country": "United States of America",
//    "lat": 24.72619444444444,
//    "lon": -81.0513611111111
//}

// MARK: - Point
class Point: Codable {
    static let logoURLs: [URL?] = {
        return [
            URL(string: "https://www.vhv.rs/dpng/d/188-1880556_travel-agency-logo-design-example-image-travel-and.png"),
            URL(string: "https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/02/attachment_49674338-e1485977590236.png?auto=format&q=60&fit=max&w=930"),
            URL(string: "https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/02/attachment_57232129-e1485977846637.jpg?auto=format&q=60&fit=max&w=930"),
            URL(string: "https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/02/attachment_37060947-e1485977888426.png?auto=format&q=60&fit=max&w=930"),
            URL(string: "https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/02/attachment_78198519-e1485978603708.jpg?auto=format&q=60&fit=max&w=930"),
            URL(string: "https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/02/attachment_35392944-e1485978936175.png?auto=format&q=60&fit=max&w=930"),
            URL(string: "https://99designs-blog.imgix.net/blog/wp-content/uploads/2017/02/attachment_71793355-e1485978853370.png?auto=format&q=60&fit=max&w=930")
        ]
    }()
    
    var id: String
    var name: String
    var country: String
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees
    
    lazy var logoUrl: URL? = {
        let number = Int.random(in: (0..<Point.logoURLs.count))
        return Point.logoURLs[number]
    }()
}

// MARK: - Resource
extension Point {
    static func page(number: Int = 0, code: String) -> Resource<Page<[Point]>> {
        return Resource(endpoint: .data, method: .get, parameters: ["code": code, "p": number])
    }
}
