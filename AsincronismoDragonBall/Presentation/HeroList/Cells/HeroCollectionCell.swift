//
//  HeroCollectionCell.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//

import UIKit

class HeroCollectionCell: UICollectionViewCell {

    static let identifier = String(describing: HeroCollectionCell.self)

    // MARK: - Outlets
    @IBOutlet weak private var heroImage: UIImageView!
    @IBOutlet weak private var heroNameLabel: UILabel!
    
    // MARK: - Configuration
    func configure(with hero: Hero) {
        
        if let photo = hero.photo, let url = URL(string: photo) {
            heroImage.loadImageRemote(url: url)
        }
        
        heroNameLabel.text = hero.name
        layer.cornerRadius = 12
        
    
    }

}
