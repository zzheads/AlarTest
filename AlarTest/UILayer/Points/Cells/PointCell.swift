//
//  PointCell.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit
import Kingfisher

final class PointCell: UITableViewCell {
    static let nibName = String(describing: PointCell.self)
    static let nib = UINib(nibName: nibName, bundle: nil)
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    func configure(with point: Point) {
        nameLabel.text = point.name
        guard let logoUrl = point.logoUrl else {
            logoImageView.kf.cancelDownloadTask()
            logoImageView.image = nil
            return
        }
        logoImageView.kf.setImage(with: logoUrl)
    }
}
