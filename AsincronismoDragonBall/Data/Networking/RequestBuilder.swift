//
//  RequestBuilder.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 4/5/25.
//

import Foundation
import OSLog

struct RequestBuilder {
    
    private var secureData: SecureDataProtocol
    
    init(secureData: SecureDataProtocol = SecureDataProvider()) {
        self.secureData = secureData
    }
    
    /// Construye la url con el endpoint dado
    func buildURL(endpoint: Endpoint) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        components.path = endpoint.path()
        return components.url
    }
    
    func build(endpoint: Endpoint) throws(NetworingError) -> URLRequest {
        
        guard let url = buildURL(endpoint: endpoint) else {
            Logger().error("URL inválida, no se ha podido construir")
            throw .invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod()
        
        // Comprobamos si es un endpoint de login
        
        if case.login(let email, let password) = endpoint {
            let loginString = String(format: "%@:%@", email, password)
            
            guard let loginData = loginString.data(using: .utf8) else {
                Logger().error("No se ha podido parsear el usuario y contraseña")
                throw .errorParsingData
            }
            
            let base64LoginData = loginData.base64EncodedString()
            request.setValue("Basic \(base64LoginData)", forHTTPHeaderField: "Authorization")
            
        } else {
            // Solo añadimos la cabecera del token a los servicios que les haga falta
            
            
            guard let token = secureData.getToken() else {
                Logger().error("Ha habido un fallo al obtenener el token en RequestBuilder")
                throw .sessionTokenMissed
            }
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }

            
        request.setValue("application/json, charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = endpoint.params()
        
        return request
    }
    
    
}


// Logger().error("Mensaje de error")
