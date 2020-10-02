//
//  PointCell.swift
//  AlarTest
//
//  Created by Алексей Папин on 01.10.2020.
//

import UIKit

// MARK: - PointCell
final class PointCell: UITableViewCell {
    private struct Constants {
        static let imageSize: CGSize = .init(width: 40, height: 40)
    }
    
    static let nibName = String(describing: PointCell.self)
    static let nib = UINib(nibName: nibName, bundle: nil)
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var imageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet private weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    private let imagesLoader: ImagesLoader = .shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageViewWidthConstraint.constant = Constants.imageSize.width
        imageViewHeightConstraint.constant = Constants.imageSize.height
    }
    
    func configure(with point: Point) {
        nameLabel.text = point.name
        guard let imageView = imageView else { return }
        guard let logoUrl = point.logoUrl else {
            imagesLoader.cancelTask(for: imageView)
            return
        }
        imagesLoader.download(url: logoUrl, into: imageView, with: Constants.imageSize)
    }
}
