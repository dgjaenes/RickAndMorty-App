//
//  CharacterListViewModel.swift
//  RickAndMorty
//

import Foundation
import Combine

final class CharacterListViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var characters = [CharacterDO]()
    @Published var isLoading = false
    @Published var currentPage = 1
    @Published var totalPages = 1
    lazy var totalCharacters = [CharacterDO]()
    lazy var cancellables = Set<AnyCancellable>()
    private var characterInteractor : CharacterInteractorProtocol
    
    init(characterInteractor: CharacterInteractorProtocol) {
        self.characterInteractor = characterInteractor
        let scheduler: DispatchQueue = DispatchQueue(label: "SearchCharactersViewModel")
        $name
            .dropFirst(1)
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: searchCharacter(name:))
            .store(in: &cancellables)
    }
    
    func initView() {
        if !totalCharacters.isEmpty {
            characters = totalCharacters
        } else {
            loadAllPages()
        }
    }
    
    private func searchCharacter(name: String) {
        DispatchQueue.main.sync { [weak self] in
            if name != "" {
                self?.characters.removeAll()
                self?.characters.append(contentsOf: self?.totalCharacters.filter({$0.name.contains(name)}) ?? [])
            } else {
                self?.characters.removeAll()
                self?.characters.append(contentsOf: self?.totalCharacters ?? [])
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
        characterInteractor.getCharacters(page: page)
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
                    self.characters.append(contentsOf: response.results)
                    self.totalCharacters = self.characters
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
