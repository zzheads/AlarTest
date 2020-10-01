//
//  PointViewController.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit
import MapKit

// MAR K: - PointViewController
class PointViewController: BaseViewController<PointViewModel> {
    private struct Constants {
        static let minZoomLevel: Double = 3
        static let maxZoomLevel: Double = 19
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var latLabel: UILabel!
    @IBOutlet private weak var lonLabel: UILabel!
    @IBOutlet private weak var centerButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    
    // MARK: - Lifecycle
    override func setupUI() {
        super.setupUI()
        title = viewModel.point.name
        [centerButton!, plusButton!, minusButton!].forEach({ $0.layer.cornerRadius = $0.frame.height / 2 })
        [centerButton!, plusButton!, minusButton!].forEach({ $0.addTarget(self, action: #selector(pressed(_:)), for: .touchUpInside) })
        
    }
    
    override func bindUIWithViewModel() {
        super.bindUIWithViewModel()
        viewModel.updateView = {
            [weak self] in
            
            guard let self = self else { return }
            self.idLabel.text = self.viewModel.point.id
            self.nameLabel.text = self.viewModel.point.name
            self.countryLabel.text = self.viewModel.point.country
            self.latLabel.text = String(format: "%.2f", self.viewModel.point.lat)
            self.lonLabel.text = String(format: "%.2f", self.viewModel.point.lon)
            
            self.mapView.addAnnotation(self.viewModel.annotation)
            self.mapView.centerCoordinate = self.viewModel.annotation.coordinate
        }
    }
    
    @objc private func pressed(_ sender: UIButton) {
        switch sender {
        case centerButton:
            self.mapView.centerCoordinate = self.viewModel.annotation.coordinate
            
        case plusButton:
            let zoomLevel = mapView.zoomLevel
            mapView.zoomLevel = min(zoomLevel, Constants.maxZoomLevel)
            
        case minusButton:
            let zoomLevel = mapView.zoomLevel
            mapView.zoomLevel = max(zoomLevel - 2, Constants.minZoomLevel)

        default:
            break
        }
    }
}

// MARK: - MKMapViewDelegate
extension PointViewController: MKMapViewDelegate {
    
}
