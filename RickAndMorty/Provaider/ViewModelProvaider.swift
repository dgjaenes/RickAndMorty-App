//
//  ViewModelInteractor.swift
//  RickAndMorty
//

import Foundation

struct ViewModelProvaider {
    static func viewModelListCharacter() -> CharacterListViewModel {
        return CharacterListViewModel(characterInteractor: InteractorProvaider.getCharactersInteractor())
    }
    static func viewModelAuhtView() -> AuthViewModel {
        return AuthViewModel()
    }
    static func viewModelLocationList() -> LocationListViewModel {
        return LocationListViewModel(locationInteractor: InteractorProvaider.getLocationsInteractor())
    }
    static func viewModelCharacterLocationList(location: LocationDO) -> CharacterLocationListViewModel {
        return CharacterLocationListViewModel(characterInteractor: InteractorProvaider.getCharactersInteractor(), location: location)
    }
}
