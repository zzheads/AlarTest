//
//  PointViewModel.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import Foundation

class PointViewModel: BaseViewModel {
    private let point: Point
    
    let title = "Точка"
    
    var updateView: ((Point) -> Void)?
    
    init(point: Point) {
        self.point = point
    }
    
    override func didBindUIWithViewModel() {
        super.didBindUIWithViewModel()
        updateView?(self.point)
    }
}
