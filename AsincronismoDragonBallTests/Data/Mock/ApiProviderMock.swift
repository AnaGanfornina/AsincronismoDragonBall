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
        return getHerosFromJson()
    }
    
    func getTransformation(id: String) async -> [TransformationDTO] {
        return getTransformationFromJson()
    }
    
    func login(username user: String, password: String) async -> String {
        return UUID().uuidString
    }
}


func getHerosFromJson() -> [HeroDTO] {
    if let url = Bundle.main.url(forResource: "Heroes", withExtension: "json") {
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
    if let url = Bundle.main.url(forResource: "Transformation", withExtension: "json") {
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
