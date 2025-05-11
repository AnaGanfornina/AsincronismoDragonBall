//
//  LoginBuilder.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 10/5/25.
//

import UIKit

final class LoginBuilder {
    func build() -> UIViewController {
        
        let appState = AppState()
        let loginViewController = LoginViewController(appState: appState)
        
        return loginViewController
        
    }
}
