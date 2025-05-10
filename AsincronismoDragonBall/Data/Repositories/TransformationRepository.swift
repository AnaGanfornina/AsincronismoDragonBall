//
//  TransformationRepository.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 10/5/25.
//

import Foundation

protocol HeroTransformationRepositoryProtocol {
    func getTransformation(filter: String) async throws-> [HeroTransformation]
}

final class HeroTransformationRepository: HeroTransformationRepositoryProtocol {
    
    private var network: ApiProviderProtocol
    
    init(network: ApiProviderProtocol) {
        self.network = network
    }
    
    // Esto está haciendo de puente.
    func getTransformation(filter: String) async throws -> [HeroTransformation] {
        do {
            let transformations = try await network.getTransformation(id: filter)
            
            return transformations.map(mapToTransformation(_:))
        } catch {
            throw AppError.init(reason: String(describing: error))
        }
        
    }
    
    private func mapToTransformation(_ dto: TransformationDTO) -> HeroTransformation {
        
        // TODO: - Unficar repositorios
    
        return HeroTransformation(
            id: UUID(uuidString: dto.id) ?? UUID(),
            name: dto.name,
            photo: dto.photo,
            description: dto.description,
            hero: mapToHero(dto.hero))
    }
    
    private func mapToHero(_ dto: HeroDTO) -> Hero {
    
        return Hero(id: UUID(uuidString: dto.id) ?? UUID(),
                    favorite: dto.favorite ?? false,
                    description: dto.description,
                    photo: dto.photo,
                    name: dto.name)
    }
    
    
    
}
