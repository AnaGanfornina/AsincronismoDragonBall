//
//  HeroTransformationRepositoryMock.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 10/5/25.
//

import Foundation

@testable import AsincronismoDragonBall

final class HeroTransformationRepositoryMock: HeroTransformationRepositoryProtocol {
    
    private var network: ApiProviderProtocol
    
    init(network: ApiProviderProtocol = ApiProviderMock() ) {
        self.network = network
    }
    
    func getTransformation(filter: String) async -> [HeroTransformation] {
        let transformations = await network.getTransformation(id: filter)
        
        return transformations.map(mapToTransformation(_:))
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
