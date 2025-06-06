//
//  ApiProviderMock.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 4/5/25.
//

import Foundation

@testable import AsincronismoDragonBall

final class ApiProviderMock: ApiProviderProtocol {
    func getHeros(name: String) async -> [HeroDTO] {
        let heroes = getHerosFromJson()
        
        guard !name.isEmpty else {
            return heroes
        }
        
        return  heroes.filter { $0.name == name }
    }
    
    func getTransformation(id: String) async -> [TransformationDTO] {
        
        let transformation = getTransformationFromJson()
        
        guard !id.isEmpty else {
            return transformation
        }
        
        return  transformation.filter { $0.hero.id == id }
        
       
    }
    
    func login(username user: String, password: String) async -> String {
        return "5EBAC267-25E3-4026-B1D7-382FDBBC836F"
    }
}


func getHerosFromJson() -> [HeroDTO] {
    
    if let url = Bundle(for: ApiProviderMock.self).url(forResource: "Heroes", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([HeroDTO].self, from: data)
            return jsonData
        } catch {
            print("error:\(error)")
        }
    }
    return []
}

func getTransformationFromJson() -> [TransformationDTO] {
    if let url = Bundle(for: ApiProviderMock.self).url(forResource: "Transformations", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([TransformationDTO].self, from: data)
            return jsonData
            
        } catch {
            print("error:\(error)")
        }
    }
    return []
}
