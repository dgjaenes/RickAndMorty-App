//
//  CharacterDO.swift
//  RickAndMorty
//

import Foundation

// MARK: - Result
struct CharacterDO: Codable {
    let id: Int
    let name: String
    let status: StatusDO
    let species: String
    let type: String
    let gender: String
    let origin, location: LocationCharacterDO
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    struct LocationCharacterDO: Codable {
        let name: String
        let url: String
    }
}

// MARK: - LocationDO

enum StatusDO: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
