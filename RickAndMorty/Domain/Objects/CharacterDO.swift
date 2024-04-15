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
    let origin, location: LocationDO
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

// MARK: - LocationDO
struct LocationDO: Codable {
    let name: String
    let url: String
}

enum StatusDO: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

extension CharacterDO: Equatable, Hashable {
    static func == (lhs: CharacterDO, rhs: CharacterDO) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.status == rhs.status &&
            lhs.species == rhs.species &&
            lhs.type == rhs.type &&
            lhs.gender == rhs.gender &&
            lhs.origin == rhs.origin &&
            lhs.location == rhs.location &&
            lhs.image == rhs.image &&
            lhs.episode == rhs.episode &&
            lhs.url == rhs.url &&
            lhs.created == rhs.created
    }
}

extension LocationDO: Equatable, Hashable {
    static func == (lhs: LocationDO, rhs: LocationDO) -> Bool {
        return lhs.name == rhs.name &&
            lhs.url == rhs.url
    }
}

extension StatusDO: Equatable, Hashable {}
