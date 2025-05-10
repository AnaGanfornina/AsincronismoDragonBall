//
//  HeroTransformationUseCase.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 10/5/25.
//

import Foundation

protocol HeroTransformationUseCaseProtocol {
    var repository: HeroTransformationRepositoryProtocol {get} // Necesita un repo con el cual comunicarse. Usamos get y set porque estamos en un protocolo y debemos indicar cómo debe ser implementada esa variable
    
    func getTransformation(id: String) async throws-> [HeroTransformation]
}

final class HeroTransformationUseCase: HeroTransformationUseCaseProtocol {
    
    
    var repository: any HeroTransformationRepositoryProtocol

    init(repository: any HeroTransformationRepositoryProtocol = HeroTransformationRepository(network: ApiProvider())) {
        self.repository = repository
    }
    
    func getTransformation(id: String) async throws-> [HeroTransformation] {
        do {
            return try await repository.getTransformation(filter: id)
        } catch {
            throw AppError.init(reason: String(describing: error))
        }
        
    }
    
}
