//
//  HeroDetailViewModel.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 11/5/25.
//

import Foundation
import Combine

final class HeroDetailViewModel: ObservableObject {
    @Published var hero: Hero?
    private var useCase: HeroTransformationUseCaseProtocol
    @Published private(set) var transformation: [HeroTransformation]?
    
    init(hero: Hero?, useCase: HeroTransformationUseCaseProtocol = HeroTransformationUseCase()){
        self.hero = hero
        self.useCase = useCase
    }
    
    func loadDataTransformation() async{
        guard let hero = hero else {
            return
        }
        
        let data = await useCase.getTransformation(id:String(describing: hero.id))
        
        DispatchQueue.main.async {
            self.transformation = data
        }
    }
    
}
