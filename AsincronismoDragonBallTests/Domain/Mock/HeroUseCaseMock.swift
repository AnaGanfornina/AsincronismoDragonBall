//
//  FakeHeroUseCase.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//
import Foundation
@testable import AsincronismoDragonBall

final class HeroUseCaseMock: HeroUseCaseProtocol {
    
    var repository: any HerosRepositoryProtocol
    
    init(repository: HerosRepositoryProtocol = HeroRepositoryMock()) {
        self.repository = repository
    }
    func getHeros(name: String) async -> [Hero] {
        return await repository.getHeros(filter: name)
    }
    
    
}
