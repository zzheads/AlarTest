//
//  PointAnnotation.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import MapKit

class PointAnnotation: NSObject {
    let point: Point
    
    init(point: Point) {
        self.point = point
        super.init()
    }
}

extension PointAnnotation: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: point.lat, longitude: point.lon)
    }
}
