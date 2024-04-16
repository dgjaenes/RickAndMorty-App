//
//  InteractorProvaider.swift
//  RickAndMorty
//

import Foundation

struct InteractorProvaider {
    static func getCharactersInteractor() -> CharacterInteractorProtocol {
        return CharacterInteractor(characterRepository: CharacterRepository())
    }
    
    static func getLocationsInteractor() -> LocationInteractorProtocol {
        return LocationInteractor(locationRepository: LocationRepository())
    }
}
