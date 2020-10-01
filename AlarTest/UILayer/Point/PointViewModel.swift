//
//  PointViewModel.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import Foundation

// MARK: - PointViewModel
class PointViewModel: BaseViewModel {
    let point: Point
    let annotation: PointAnnotation
    
    var updateView: (() -> Void)?
    
    init(point: Point) {
        self.point = point
        self.annotation = PointAnnotation(point: point)
    }
    
    override func didBindUIWithViewModel() {
        super.didBindUIWithViewModel()
        updateView?()
    }
}
