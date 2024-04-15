//
//  CharacterRepository.swift
//  RickAndMorty
//

import Foundation
import Combine

protocol CharacterRepositoryProtocol {
    func getCharacter(id: String) -> AnyPublisher<CharacterDO, RAMAppError>
    func getCharacters(page: Int?) -> AnyPublisher<CharacterListDO, RAMAppError>
}

class CharacterRepository: ManagerAppRepository, CharacterRepositoryProtocol {
    
    struct TransactionsAPI {
        static let scheme = "https"
        static let host = "rickandmortyapi.com"
        static let path = "/api/character"
    }
    
    func getCharacter(id: String) -> AnyPublisher<CharacterDO, RAMAppError> {
        return execute(components: makeUrltComponents(id: id))
    }
    
    func getCharacters(page: Int?) -> AnyPublisher<CharacterListDO, RAMAppError> {
        return execute(components: makeUrltComponents(page: page))
    }
    
    func makeUrltComponents(id: String? = nil, page: Int? = nil) -> URLComponents {
        var components = URLComponents()
        components.scheme = TransactionsAPI.scheme
        components.host = TransactionsAPI.host
        components.path = "\(TransactionsAPI.path)\(id ?? "")"
        if let id = id {
            components.path = "\(TransactionsAPI.path)\(id)"
        }
        else if let page = page {
            let pageParameter = URLQueryItem(name: "page", value: String(page))
            components.queryItems = [pageParameter]
        }
        
        return components
    }
}

