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
        let appState = AppState()
        let viewModel = HeroListViewModel()
        let rootViewController = HeroListViewController(appState: appState, viewModel: viewModel)
        
        let controller = UINavigationController(rootViewController: rootViewController)
        controller.modalPresentationStyle = .fullScreen
        return controller
        
    }
}
