//
//  ManagerTransactionsAppRepositoryMock.swift
//  RickAndMortyTests
//

import Foundation
@testable import RickAndMorty
import Combine
import Firebase
import FirebaseAuth
import FirebaseCore

class ManagerAppRepositoryMock {
    
    static let shared = ManagerAppRepositoryMock()
    
    func execute<T>(components: URLComponents) -> AnyPublisher<T, RAMAppError> where T: Decodable {
        let session = URLSessionMock()
        
        return session.dataTaskPublisher(jsonName: components.path.replacingOccurrences(of: "/", with: ""))
            .mapError { error in
            .network(description: error.localizedDescription)
            }
            .print()
            .map { data, response  in
                return data
            }
            .flatMap() { item in
                self.decode(item)
            }
            .eraseToAnyPublisher()
    }
    
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, RAMAppError> {
        let decoder = JSONDecoder()
        
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
            .parsing(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}

protocol URLSessionMockPublisher {
    func dataTaskPublisher(jsonName: String) -> URLSession.DataTaskPublisher
}

class URLSessionMock: URLSessionMockPublisher {
    func dataTaskPublisher(jsonName: String) -> URLSession.DataTaskPublisher {

        return URLSession.shared.dataTaskPublisher(for: Bundle(for: type(of: self)).url(forResource: jsonName, withExtension: "json")!)
    }
}

