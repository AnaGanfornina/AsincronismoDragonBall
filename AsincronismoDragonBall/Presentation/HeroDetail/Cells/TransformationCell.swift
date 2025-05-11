//
//  TransformationCell.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//

import UIKit

class TransformationCell: UICollectionViewCell {
    static let identifier = String(describing: TransformationCell.self)
    
    // MARK: - Outlets
    
    @IBOutlet weak var transformationImage: UIImageView!
    
    @IBOutlet weak var transformationNameLabel: UILabel!
    // MARK: - Configuration
    func configure(whith transformation: HeroTransformation){
        
        if let photo = transformation.photo, let url = URL(string: photo) {
            transformationImage.loadImageRemote(url: url)
        }
        transformationNameLabel.text = transformation.name
        layer.cornerRadius = 12
    }

}
