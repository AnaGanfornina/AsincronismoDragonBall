//
//  AppState.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 10/5/25.
//

import Foundation
import Combine



enum LoginStatus {
    case loading
    case success
    case error(reason: String)
    case notValidated
}

final class AppState: ObservableObject {
    @Published var loginStatus: LoginStatus = .loading
    //@Published var heroListStatus: HeroListStatus = .loading
    
    // MARK: - Dpendencies
    
    private var loginUseCase: LoginUseCaseProtocol
    
    
    // MARK: - Initializer
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
    }
    
    // MARK: - Funciones de LoginUseCase
    
    func loginApp(user: String, pass: String){
        Task {
            
            do {
                if try await loginUseCase.login(user: user, password: pass){
                    self.loginStatus = .success
                }
            } catch {
                self.loginStatus = .error(reason: error.localizedDescription)
                
            }

        }
    }
    
    func validateLogin() {
        Task {
            if await loginUseCase.isValidateToken(){
                self.loginStatus = .success
            } else {
                self.loginStatus = .notValidated
            }
        }
    }
    
    func closeSessionUser() {
        Task {
            await loginUseCase.logout()
            self.loginStatus = .loading
        }
    }
    
}

