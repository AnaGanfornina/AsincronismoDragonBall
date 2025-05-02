//
//  SecureDataProvider.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 2/5/25.
//

import Foundation
import KeychainSwift

protocol SecureDataProtocol {
    func getToken() -> String?
    func setToken(_ token: String)
    func clearToken()
}

///Hace uso de KEychain para guardar la información del token en el llavero del dispositivo
final class SecureDataProvider: SecureDataProtocol {
    
    private let keyToken = "ConstatnKeyToken" // TODO: Hacer que esto se pueda meter tambien desde fuera y podamos tener varios
    
    private let keyChain = KeychainSwift() // esta es la constante con la que vamos a acceder a los servicios de la librería
    
    func getToken() -> String? {
        keyChain.get(keyToken)
    }
    
    func setToken(_ token: String) {
        keyChain.set(token, forKey: keyToken)
    }
    
    func clearToken() {
        keyChain.delete(keyToken)
    }
    
    
}
