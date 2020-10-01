//
//  PointViewController.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit
import MapKit

class PointViewController: BaseViewController<PointViewModel> {
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var latLabel: UILabel!
    @IBOutlet private weak var lonLabel: UILabel!
    
    override func setupUI() {
        super.setupUI()
        title = viewModel.title
    }
    
    override func bindUIWithViewModel() {
        super.bindUIWithViewModel()
        viewModel.updateView = {
            [weak self] point in
            
            self?.idLabel.text = point.id
            self?.nameLabel.text = point.name
            self?.countryLabel.text = point.country
            self?.latLabel.text = point.lat.description
            self?.lonLabel.text = point.lon.description
            
            let annotation = PointAnnotation(point: point)
            self?.mapView.addAnnotation(annotation)
            self?.mapView.centerCoordinate = annotation.coordinate
        }
    }
    
}

extension PointViewController: MKMapViewDelegate {
    
}
