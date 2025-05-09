//
//  HeroRepositoryMock.swift
//  AsincronismoDragonBallTests
//
//  Created by Ana on 9/5/25.
//

import Foundation

@testable import AsincronismoDragonBall

final class HeroRepositoryMock: HerosRepositoryProtocol {
    private var network: ApiProviderProtocol
    
    init(network: ApiProviderProtocol = ApiProviderMock()) {
        self.network = network
    }
    
    func getHeros(filter: String) async -> [Hero] {
        let heroes = await network.getHeros(name: filter)
        
        
        return heroes.map(mapToHero(_:))
    }
    
    private func mapToHero(_ dto: HeroDTO) -> Hero {
    
        return Hero(id: UUID(uuidString: dto.id) ?? UUID(),
                    favorite: dto.favorite ?? false,
                    description: dto.description,
                    photo: dto.photo,
                    name: dto.name)
    }
    
    
}
