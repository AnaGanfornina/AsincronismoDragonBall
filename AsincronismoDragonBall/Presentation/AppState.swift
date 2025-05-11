//
//  AppState.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 10/5/25.
//

import Foundation
import Combine

// ES ESTO UN VIEWMODEL?

enum LoginStatus {
    case loading
    case success
    case error(reason: String)
    case notValidated
}

final class AppState: ObservableObject {
    @Published var loginStatus: LoginStatus = .loading
    
    // Dependencias
    
    private var useCase: LoginUseCaseProtocol
    
    // MARK: -Initializer
    
    init(useCase: LoginUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func loginApp(user: String, pass: String){
        Task {
            /*
            if await useCase.login(user: user, password: pass){
                self.loginStatus = .success
            } else {
                self.loginStatus = .error(reason: "Ha ocurrido un error en el login")
            }
            */
            do {
                if try await useCase.login(user: user, password: pass){
                    self.loginStatus = .success
                }
            } catch {
                self.loginStatus = .error(reason: error.localizedDescription)
                
            }

        }
    }
    
    func validateLogin() {
        Task {
            if await useCase.isValidateToken(){
                self.loginStatus = .success
            } else {
                self.loginStatus = .notValidated
            }
        }
    }
    
    func closeSessionUser() {
        Task {
            await useCase.logout()
            self.loginStatus = .loading
        }
    }
    
}

