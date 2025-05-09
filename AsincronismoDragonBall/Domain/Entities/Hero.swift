//
//  Hero.swift
//  AsincronismoDragonBall
//
//  Created by Ana on 9/5/25.
//

import Foundation

struct Hero: Codable {
    let id: UUID
    let favorite: Bool?
    let description: String?
    let photo: String?
    let name: String?
}
