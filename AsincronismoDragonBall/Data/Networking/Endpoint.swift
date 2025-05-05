//
//  Endpoint.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 4/5/25.
//

import Foundation
import OSLog

enum Endpoint {
    case login(username: String, password: String)
    case heroes(name: String)
    case transformation(id: String)
    
    // TODO: Realmente usamos el isAuthoritationRequired?
    /*
    /// Variable para indiocar si el endpoint debe llevar cabecera de autenticación con el token /
    var isAuthoritationRequired: Bool {
        switch self {
        case .heroes, .transformation:
            return true
        case .login:
            return false
        }
    }
    */
    func path() -> String {
        switch self {
        case .login:
            return "/api/auth/login"
        case .heroes:
            Logger().debug("Ha entrado por heroes")
            return "/api/heros/all"
        case .transformation:
            Logger().debug("Ha entrado por transformation")
            return "/api/heros/tranformations"
        }
    }
    
    func httpMethod() -> String {
        switch self {
        case .login, .heroes, .transformation:
            return HTTPMethods.POST.rawValue
        }
    }
    
    /// Estamos configurando lo que habría en el body de nuestra request
    func params() -> Data? {
        switch self {
            
        case .login(username: let username, password: let password):
            let atributes = ["username": username, "password": password]
            // Creamos data a partir de un diccionario
            let data = try? JSONSerialization.data(withJSONObject: atributes)
            return data
            
        case .heroes(name: let name):
            let atributes = ["name": name]
            let data = try? JSONSerialization.data(withJSONObject: atributes) // Esto es para poder codifigar un diccionario y poder pasarselo como data al la api
            //TODO: Implememtar el HeroModelRequest visto en clase
            return data
        
        case .transformation(id: let id):
            let atributes = ["id": id ]
            let data = try? JSONSerialization.data(withJSONObject: atributes)
            return data
        }
    }
}
