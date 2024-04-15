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
}
