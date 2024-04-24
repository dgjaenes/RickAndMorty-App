//
//  RepositoryProvaider.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 24/4/24.
//

import Foundation

struct RepositoryProvaider {
    static func getCharacterRepository() -> CharacterRepositoryProtocol {
        return CharacterRepository()
    }
    
    static func getLocationsRepository() -> LocationRepositoryProtocol {
        return LocationRepository()
    }
}
