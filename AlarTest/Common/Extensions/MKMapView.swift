//
//  MKMapView.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import MapKit

extension MKMapView {
    public var zoomLevel: Double {
        get {
            return (log2(360 * (Double(self.frame.size.width / 256) / self.region.span.longitudeDelta)) + 1)
        }

        set (newZoomLevel) {
            self.setCenterCoordinate(coordinate: self.centerCoordinate, zoomLevel: newZoomLevel, animated: false)
        }
    }
    
    private func setCenterCoordinate(coordinate: CLLocationCoordinate2D, zoomLevel: Double, animated: Bool) {
        let span = MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 360 / pow(2, zoomLevel) * Double(self.frame.size.width) / 256)
        self.setRegion(MKCoordinateRegion(center: self.centerCoordinate, span: span), animated: animated)
    }
}
