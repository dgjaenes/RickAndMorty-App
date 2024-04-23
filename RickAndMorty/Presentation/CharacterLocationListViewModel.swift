//
//  CharacterLocationListViewModel.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 23/4/24.
//

import Foundation
import Combine

final class CharacterLocationListViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var characters = [CharacterDO]()
    @Published var isLoading = false
    lazy var totalCharacters = [CharacterDO]()
    lazy var cancellables = Set<AnyCancellable>()
    private var characterInteractor: CharacterInteractorProtocol
    private var location: LocationDO
    
    init(characterInteractor: CharacterInteractorProtocol, location: LocationDO) {
        self.characterInteractor = characterInteractor
        self.location = location
        name = location.name
    }
    
    func initView() {
        if !totalCharacters.isEmpty {
            characters = totalCharacters
        } else {
            let ids = location.getIds()
            for item in ids {
                loadCharacter(id: item)
            }
        }
    }
    
    private func loadCharacter(id: Int) {
        DispatchQueue.main.async {
            self.isLoading = false
        }
        characterInteractor.getCharacter(id: String(id))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                switch completion {
                case .failure(let error):
                    debugPrint("Error loading character: \(id), with error: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.characters.append(response)
                    self.totalCharacters = self.characters
                    //self.totalPages = response.info.pages
                    
//                    self.currentPage += 1
//                    if self.currentPage <= self.totalPages {
//                        self.loadAllPages()
//                    }
                }
            })
            .store(in: &cancellables)
    }
}

