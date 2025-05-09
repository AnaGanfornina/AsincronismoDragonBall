//
//  HeroUseCase.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 9/5/25.
//

import Foundation

protocol HeroUseCaseProtocol {
    var repository: HerosRepositoryProtocol{get} // Necesita un repo con el cual comunicarse. Usamos get y set porque estamos en un protocolo y debemos indicar cómo debe ser implementada esa variable
    
    func getHeros(name: String) async -> [Hero]
}

final class HeroUseCase: HeroUseCaseProtocol {
    var repository: any HerosRepositoryProtocol
    
    init(repository: any HerosRepositoryProtocol = HerosRepository(network: ApiProvider())) {
        self.repository = repository
    }
    
    func getHeros(name: String) async -> [Hero] {
        return await repository.getHeros(filter: name)
    }
    
    
}
