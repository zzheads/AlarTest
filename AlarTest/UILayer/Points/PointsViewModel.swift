//
//  PointsViewModel.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import Foundation

class PointsViewModel: BaseViewModel {
    private let code: String
    private lazy var loader: Loader = .init(code: code)
    private let screenFactory: ScreenFactory = .shared
    let title = "Список"
    var points: [Point] = []
    
    var addPoints: (([IndexPath]) -> Void)?
    var reload: (() -> Void)?
    
    init(code: String) {
        self.code = code
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMorePoints()
    }
    
    func getMorePoints() {
        guard !loader.isLoading else { return }
        loader.getPoints(completion: {
            [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case let .success(points):
                let indexPaths = (self.points.count..<self.points.count + points.count).map { IndexPath(row: $0, section: 0) }
                self.points.append(contentsOf: points)
                self.addPoints?(indexPaths)
                
            case .failure:
                break
            }
        })
    }
    
    func select(at index: Int) {
        let controller = screenFactory.pointViewController(point: points[index])
        showController?(controller)
    }
}
