//
//  LoginUseCase.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 5/5/25.
//

import Foundation
import KeychainSwift

protocol LoginUseCaseProtocol {
    var repository: LoginRepositoryProtocol {get} // Necesita un repo con el cual comunicarse. Usamos get porque estamos en un protocolo y debemos indicar cómo debe ser implementada esa variable
    func login(user: String, password: String) async -> Bool
    func logout() async
    func isValidateToken() async -> Bool
}

final class LoginUseCase: LoginUseCaseProtocol {
    
    var repository: any LoginRepositoryProtocol
    let keychain = SecureDataProvider()
    
    
    init(repository: any LoginRepositoryProtocol = LoginRepository(network: ApiProvider())) {
        self.repository = repository
    }
    
    
    
    func login(user: String, password: String) async -> Bool {
        
        let token = await repository.loginApp(user: user, pass: password)
        //Aquí le decimos que sea el repo quien se logee
        
        if token != "" {
            keychain.setToken(token)
            return true
        } else {
            keychain.clearToken()
            return false
        }
    }
    
    func logout() async {
        keychain.clearToken()
    }
    
    func isValidateToken() async -> Bool {
        keychain.getToken() != ""
    }    
}
