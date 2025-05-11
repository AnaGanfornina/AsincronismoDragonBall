//
//  HeroCell.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//

import UIKit

class HeroCell: UITableViewCell {
    static let identifier = String(describing: HeroCell.self)

    // MARK: - Outlets
    @IBOutlet weak private var heroImage: UIImageView!
    @IBOutlet weak private var heroNameLabel: UILabel!
    
    // MARK: - Configuration
    func configure(with hero: Hero) {
        heroNameLabel.text = hero.name
        if let photo = hero.photo, let url = URL(string: photo) {
            heroImage.loadImageRemote(url: url)
        }
        heroNameLabel.text = hero.name
        layer.cornerRadius = 12
        
    
    }
    
}
