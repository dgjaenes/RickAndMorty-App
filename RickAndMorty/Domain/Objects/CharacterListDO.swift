//
//  CharacteListDO.swift
//  RickAndMorty
//

import Foundation

// MARK: - CharacteListDO
struct CharacterListDO: Codable {
    let info: InfoDO
    let results: [CharacterDO]
}

// MARK: - Info
struct InfoDO: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}
