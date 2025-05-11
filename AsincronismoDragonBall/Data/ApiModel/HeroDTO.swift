//
//  HeroDTO.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 4/5/25.
//

import Foundation

struct HeroDTO: Codable {
    let id: String
    var favorite: Bool?
    let name: String?
    let description: String?
    let photo: String?
    
    
}
extension HeroDTO {
    
    func mapToHero() -> Hero {
    
        return Hero(id: UUID(uuidString: self.id) ?? UUID(),
                    favorite: self.favorite ?? false,
                    description: self.description,
                    photo: self.photo,
                    name: self.name)
    }
}
