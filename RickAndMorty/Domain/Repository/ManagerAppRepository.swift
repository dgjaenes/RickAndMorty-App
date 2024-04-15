//
//  ManagerAppRepository.swift
//  RickAndMorty
//

import Foundation
import Combine

class ManagerAppRepository {
    
    private let session: URLSession
    let cache = NSCache<AnyObject, AnyObject>()
    
    init(session: URLSession = .shared) {
        self.session = session
        cache.countLimit = 50
    }
    
    internal func execute<T>(components: URLComponents, inCacheValid: Bool = true) -> AnyPublisher<T, RAMAppError> where T: Decodable {
        guard let url = components.url else {
            let error = RAMAppError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }

        if inCacheValid, let cached = cache.object(forKey: url as AnyObject) as? T {
            return Just(cached)
                .setFailureType(to: RAMAppError.self)
                .eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        return session.dataTaskPublisher(for: request)
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .print()
            .map { data, response  in
                guard let response = response as? HTTPURLResponse else {
                    print("error httpUrlResponse")
                    return data
                }
                guard 200..<300 ~= response.statusCode else {
                    print(response.statusCode)
                    return data
                }
                return data
            }
            .flatMap() { item in
                self.decode(item)
            }
            .handleEvents(receiveOutput: { [weak self] decoded in
                self?.cache.setObject(decoded as AnyObject, forKey: url as AnyObject)
            })
            .eraseToAnyPublisher()
    }
    
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, RAMAppError> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        return Just(data)
            .decode(type: T.self, decoder: decoder)
            .mapError { error in
            .parsing(description: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}

enum RAMAppError: Error {
    case parsing(description: String)
    case network(description: String)
}

