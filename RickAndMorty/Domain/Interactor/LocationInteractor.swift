//
//  LocationInteractor.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 16/4/24.
//

import Foundation
import Combine

protocol LocationInteractorProtocol {
    func getLocation(id: String) -> AnyPublisher<LocationDO, RAMAppError>
    func getLocations(page: Int?) -> AnyPublisher<LocationListDO, RAMAppError>
}

class LocationInteractor: LocationInteractorProtocol {
    
    var locationRepository: LocationRepositoryProtocol
    
    init(locationRepository: LocationRepositoryProtocol) {
        self.locationRepository = locationRepository
    }
    
    func getLocation(id: String) -> AnyPublisher<LocationDO, RAMAppError> {
        locationRepository.getLocation(id: id)
    }
    
    func getLocations(page: Int?) -> AnyPublisher<LocationListDO, RAMAppError> {
        locationRepository.getLocations(page: page)
    }
}
