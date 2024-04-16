//
//  LocationsListViewModel.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 16/4/24.
//

import Foundation
import Combine

class LocationListViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var locations = [LocationDO]()
    @Published var isLoading = false
    @Published var currentPage = 1
    @Published var totalPages = 1
    lazy var totalLocations = [LocationDO]()
    lazy var cancellables = Set<AnyCancellable>()
    private var locationInteractor : LocationInteractorProtocol

    init(locationInteractor: LocationInteractorProtocol) {
        self.locationInteractor = locationInteractor
        let scheduler: DispatchQueue = DispatchQueue(label: "SearchLocationsViewModel")
        $name
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: searchLocation(name:))
            .store(in: &cancellables)
    }

    func initView() {
        if !totalLocations.isEmpty {
            locations = totalLocations
        } else {
            loadAllPages()
        }
    }

    private func searchLocation(name: String) {
        DispatchQueue.main.sync { [weak self] in
            if name != "" {
                self?.locations.removeAll()
                self?.locations.append(contentsOf: self?.totalLocations.filter({$0.name.contains(name)}) ?? [])
            } else {
                self?.locations.removeAll()
                self?.locations.append(contentsOf: self?.totalLocations ?? [])
            }
            print("")
        }
    }

    private func loadAllPages() {
        DispatchQueue.main.async {
            self.isLoading = false
        }
        var page: Int?
        page = currentPage > 1 && currentPage <= self.totalPages
                ? currentPage
                : nil
        locationInteractor.getLocations(page: page)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                switch completion {
                case .failure(let error):
                    debugPrint("Error loading page: \(self.currentPage) with error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.locations.append(contentsOf: response.results)
                    self.totalLocations = self.locations
                    self.totalPages = response.info.pages

                    self.currentPage += 1
                    if self.currentPage <= self.totalPages {
                        self.loadAllPages()
                    }
                }
            })
            .store(in: &cancellables)
    }
}
