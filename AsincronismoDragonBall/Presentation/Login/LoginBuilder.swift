//
//  LoginBuilder.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 10/5/25.
//

import UIKit

final class LoginBuilder {
    func build() -> UIViewController {
        
        let useCase = LoginUseCase()
        let appState = AppState(useCase: useCase)
        let loginViewController = LoginViewController(appState: appState)
        
        return loginViewController
        
    }
}
