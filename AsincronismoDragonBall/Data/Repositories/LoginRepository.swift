//
//  LoginRepository.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 5/5/25.
//

import Foundation


protocol LoginRepositoryProtocol {
    func loginApp(user: String, pass: String) async throws-> String // devuelve el token JWT
}

final class LoginRepository: LoginRepositoryProtocol{
     
    private var network:  ApiProviderProtocol
    
    init(network: ApiProviderProtocol) {
        self.network = network
    }
    
    func loginApp(user: String, pass: String) async throws -> String {
        // Esto está haciendo de puente. Aunque aqui estamos devoluendo un String y no hay nada que convertir. Pero si lo hubiera se haría aqui
        
        do {
            return try await network.login(username: user, password: pass)
        } catch {
            throw AppError.init(reason: String(describing: error))
        }
    }
    
    
}
