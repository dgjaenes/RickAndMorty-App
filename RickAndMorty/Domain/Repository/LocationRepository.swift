//
//  LocationRepository.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 16/4/24.
//

import Foundation
import Combine

protocol LocationRepositoryProtocol {
    func getLocation(id: String) -> AnyPublisher<LocationDO, RAMAppError>
    func getLocations(page: Int?) -> AnyPublisher<LocationListDO, RAMAppError>
}

class LocationRepository: ManagerAppRepository, LocationRepositoryProtocol {
    
    struct TransactionsAPI {
        static let scheme = "https"
        static let host = "rickandmortyapi.com"
        static let path = "/api/location"
    }
    
    func getLocation(id: String) -> AnyPublisher<LocationDO, RAMAppError> {
        return execute(components: makeUrltComponents(id: id))
    }
    
    func getLocations(page: Int?) -> AnyPublisher<LocationListDO, RAMAppError> {
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


