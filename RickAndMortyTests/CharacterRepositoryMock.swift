//
//  CharacterRepositoryMock.swift
//  RickAndMortyTests
//

import Foundation
@testable import RickAndMorty
import Combine

class CharacterRepositoryMock: CharacterRepository {
    
    let mockRepository = ManagerAppRepositoryMock.shared
    
    override func execute<T>(components: URLComponents) -> AnyPublisher<T, RAMAppError> where T: Decodable {
        return mockRepository.execute(components: components)
    }
}
