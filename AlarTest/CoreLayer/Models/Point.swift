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
    var id: String
    var name: String
    var country: String
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees
    
    var logoUrl: URL? {
        return URL(string: "https://www.vhv.rs/dpng/d/188-1880556_travel-agency-logo-design-example-image-travel-and.png")
    }
}

// MARK: - Resource
extension Point {
    static func page(number: Int = 0, code: String) -> Resource<Page<[Point]>> {
        return Resource(endpoint: .data, method: .get, parameters: ["code": code, "p": number])
    }
}
