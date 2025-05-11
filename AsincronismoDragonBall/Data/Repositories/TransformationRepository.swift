//
//  TransformationRepository.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 10/5/25.
//

import Foundation

protocol HeroTransformationRepositoryProtocol {
    func getTransformation(filter: String) async -> [HeroTransformation]
}

final class HeroTransformationRepository: HeroTransformationRepositoryProtocol {
    
    private var network: ApiProviderProtocol
    
    init(network: ApiProviderProtocol) {
        self.network = network
    }
    
    // Esto está haciendo de puente.
    func getTransformation(filter: String) async -> [HeroTransformation] {
        let transformations = await network.getTransformation(id: filter)
        
        return transformations.map { $0.mapToTransformation() }
    }    
}
