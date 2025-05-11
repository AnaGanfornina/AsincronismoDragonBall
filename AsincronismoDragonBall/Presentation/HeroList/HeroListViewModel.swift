//
//  HeroListViewModel.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//

import Foundation
import Combine


enum HeroListState: Equatable{
    case error(reason: String)
    case loading
    case success
}

final class HeroListViewModel: ObservableObject {
    //Lista de heroes
    @Published var heros = [Hero]()
    
    //Combine
    var suscriptors = Set<AnyCancellable>()
    private var useCaseHeros: HeroUseCaseProtocol
    
    init(useCase: HeroUseCaseProtocol = HeroUseCase()) {
        self.useCaseHeros = useCase
        Task{
            await loadHeros()
        }
    }
    
    func loadHeros() async {
        let data = await useCaseHeros.getHeros(name: "")
        
        DispatchQueue.main.async {
            self.heros = data
        }
    }
}

