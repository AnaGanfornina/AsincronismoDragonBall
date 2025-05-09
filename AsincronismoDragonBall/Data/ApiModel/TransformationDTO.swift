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

