//
//  HeroDetailBuilder.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//

import Foundation
import UIKit



final class HeroDetailBuilder{
    
    private var viewModel: HeroDetailViewModel
    
    init(hero: Hero) {
        self.viewModel = HeroDetailViewModel(hero: hero)
    }
        
        func build() -> UIViewController {
            HeroDetailViewController(viewModel: viewModel)
        }
    
    }

