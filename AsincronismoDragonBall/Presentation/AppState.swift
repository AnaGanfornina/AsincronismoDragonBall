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
/*
enum HeroListStatus {
    case loading
    case success
    case error(reason: String)
}
*/
final class AppState: ObservableObject {
    @Published var loginStatus: LoginStatus = .loading
    //@Published var heroListStatus: HeroListStatus = .loading
    
    // MARK: - Dpendencies
    
    private var loginUseCase: LoginUseCaseProtocol
    private var heroUseCase: HeroUseCaseProtocol
    private var heroTransformatioUseCase: HeroTransformationUseCaseProtocol
    
    
    // MARK: - Initializer
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase(),
         heroUseCase: HeroUseCaseProtocol = HeroUseCase(),
         heroTransformatioUseCase: HeroTransformationUseCaseProtocol = HeroTransformationUseCase()
    ) {
        self.loginUseCase = loginUseCase
        self.heroUseCase = heroUseCase
        self.heroTransformatioUseCase = heroTransformatioUseCase
    }
    /*
    // MARK: - Funciones de heroUseCase
    
    func getHeros(name: String){
        Task{
            await heroUseCase.getHeros(name: name)
        }
        
    }
   */
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

