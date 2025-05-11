//
//  HeroListBuilder.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//

import Foundation
import UIKit

final class HeroesListBuilder {
    func build() -> UIViewController {
        
        let useCase = HeroUseCase()
        let viewModel = HeroListViewModel(useCase: useCase)
        let rootViewController = HeroListViewController( appState: viewModel.appState, viewModel: viewModel)
        
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.modalPresentationStyle = .fullScreen
        return controller
        
    }
}
