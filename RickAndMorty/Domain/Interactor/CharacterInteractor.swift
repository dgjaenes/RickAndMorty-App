//
//  CharacterInteractor.swift
//  RickAndMorty
//

import Foundation
import Combine

protocol CharacterInteractorProtocol {
    func getCharacter(id: String) -> AnyPublisher<CharacterDO, RAMAppError>
    func getCharacters(page: Int?) -> AnyPublisher<CharacterListDO, RAMAppError>
}

class CharacterInteractor: CharacterInteractorProtocol {
    
    var characterRepository: CharacterRepositoryProtocol
    
    init(characterRepository: CharacterRepositoryProtocol) {
        self.characterRepository = characterRepository
    }
    
    func getCharacter(id: String) -> AnyPublisher<CharacterDO, RAMAppError> {
        characterRepository.getCharacter(id: id)
    }
    
    func getCharacters(page: Int?) -> AnyPublisher<CharacterListDO, RAMAppError> {
        characterRepository.getCharacters(page: page)
    }
}
