//
//  TransformationDTO.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 4/5/25.
//

import Foundation

struct TransformationDTO: Codable{
    let id: String
    let name: String
    let description: String
    let photo: String
    let hero: HeroDTO
}

extension TransformationDTO {
    
    func mapToTransformation() -> HeroTransformation {
        
        
        return HeroTransformation(
            id: UUID(uuidString: self.id) ?? UUID(),
            name: self.name,
            photo: self.photo,
            description: self.description,
            hero: self.hero.mapToHero())
    }
}
