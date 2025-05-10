//
//  HerosRepsitory.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 9/5/25.
//

import Foundation

protocol HerosRepositoryProtocol {
    func getHeros(filter: String) async throws -> [Hero]
}


final class HerosRepository: HerosRepositoryProtocol {
    
    private var network: ApiProviderProtocol
    
    init(network: ApiProviderProtocol) {
        self.network = network
    }
    
    // Esto está haciendo de puente.
    func getHeros(filter: String) async throws -> [Hero] {
        do {
            let heroes = try await network.getHeros(name: filter)
            return heroes.map(mapToHero(_:))
            
        } catch {
            throw AppError.init(reason: String(describing: error))
        }
        
    }
    
    private func mapToHero(_ dto: HeroDTO) -> Hero {
    
        return Hero(id: UUID(uuidString: dto.id) ?? UUID(),
                    favorite: dto.favorite ?? false,
                    description: dto.description,
                    photo: dto.photo,
                    name: dto.name)
    }
    
}
