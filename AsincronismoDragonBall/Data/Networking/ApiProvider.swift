//
//  ApiProvider.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 4/5/25.
//

import Foundation
import OSLog

protocol ApiProviderProtocol {
    func login(username: String, password: String) async -> String
    func getHeros(name: String) async -> [HeroDTO]
    func getTransformation(id: String) async -> [TransformationDTO]
}

    final class ApiProvider: ApiProviderProtocol {
    var session: URLSession
    var requestBuilder: RequestBuilder
    
    init(session: URLSession, requestBuilder: RequestBuilder) {
        self.session = session
        self.requestBuilder = requestBuilder
    }
    // MARK: - Funcion para hacer login
    
    func login(username: String, password: String) async -> String {
        var tokenJWT: String = ""
        do {
            let request = try requestBuilder.build(endpoint: .login(username: username, password: password))
            let (data, response) = try await session.data(for: request)
            
            if let resp = response as? HTTPURLResponse {
                if resp.statusCode == HTTPResponseCodes.SUCCESS {
                    tokenJWT = String(decoding: data, as: UTF8.self)
                }
            }
            
        } catch {
            Logger().error("\(error)")
            // TODO: generar nuestro propio error para saber qué esta pasando

        }
        return tokenJWT
    }
    
    
    // MARK: - Funcion para devolver los heroes
    
    func getHeros(name: String = "") async -> [HeroDTO]{
        var modelReturn = [HeroDTO]()
        
        do {
            let request = try requestBuilder.build(endpoint: .heroes(name: name))
            let (data, response) = try await session.data(for: request)
            
            if let resp = response as? HTTPURLResponse{
                if  resp.statusCode == HTTPResponseCodes.SUCCESS {
                    modelReturn = try! JSONDecoder().decode([HeroDTO].self, from: data)
                }
            }
            
        } catch {
            Logger().error("\(error)")
            
        }
        return modelReturn
    }
    
    // MARK: - Funcion para devolver transformaciones
    
    func getTransformation(id: String = "") async -> [TransformationDTO]{
        var modelReturn = [TransformationDTO]()
        
        do {
            let request = try requestBuilder.build(endpoint: .transformation(id: id))
            let (data, response) = try await session.data(for: request)
            
            if let resp = response as? HTTPURLResponse{
                if  resp.statusCode == HTTPResponseCodes.SUCCESS {
                    modelReturn = try! JSONDecoder().decode([TransformationDTO].self, from: data)
                }
            }
            
        } catch {
            Logger().error("\(error)")
            
        }
        return modelReturn
    }
    
    // MARK: - Función para manegar las respuesstas de la api
    // TODO: Prueba a unificar las respuestas de la api
    
   
   
}

