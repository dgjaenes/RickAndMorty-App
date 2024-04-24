//
//  InteractorProvaider.swift
//  RickAndMorty
//

import Foundation

struct InteractorProvaider {
    static func getCharactersInteractor() -> CharacterInteractorProtocol {
        return CharacterInteractor(characterRepository: RepositoryProvaider.getCharacterRepository())
    }
    
    static func getLocationsInteractor() -> LocationInteractorProtocol {
        return LocationInteractor(locationRepository: RepositoryProvaider.getLocationsRepository())
    }
}
