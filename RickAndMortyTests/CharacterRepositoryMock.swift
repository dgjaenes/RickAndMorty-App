//
//  CharacterRepositoryMock.swift
//  RickAndMortyTests
//

import Foundation
@testable import RickAndMorty
import Combine

class CharacterRepositoryMock: CharacterRepository {
    
    let mockRepository = ManagerAppRepositoryMock.shared
    
    override internal func execute<T>(components: URLComponents, inCacheValid: Bool = true) -> AnyPublisher<T, RAMAppError> where T: Decodable {
        return mockRepository.execute(components: components)
    }
}
