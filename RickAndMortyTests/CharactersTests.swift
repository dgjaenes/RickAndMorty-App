//
//  RickAndMortyTests.swift
//  RickAndMortyTests
//

import XCTest
@testable import RickAndMorty
import Combine

class CharactersTests: XCTestCase {
    
    private var disposables = Set<AnyCancellable>()
    private var interactor: CharacterInteractor!
    private var viewModelTest: CharacterListViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        interactor = CharacterInteractor(characterRepository: CharacterRepositoryMock())
        viewModelTest = CharacterListViewModel(characterInteractor: interactor)
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        viewModelTest = nil
        try super.setUpWithError()
    }
    
    func testPerformanceExample() throws {
        self.measure {
        }
    }
    
    func testCharactersTestsViewModel() throws {
        
        let characters = CharactersResponseFactory.makeCharactersResponse().results
        viewModelTest.characters = characters
        let expectation = XCTestExpectation(description: "Characters are update")
        
            viewModelTest.$characters.sink { items in
            XCTAssertEqual(items.count, 3)
            XCTAssertTrue(items[0].name.contains("Rick Sanchez"))
            expectation.fulfill()
        }.store(in: &disposables)
        wait(for: [expectation], timeout: 1)
    }
    
    func testInteractorCharactersTests() throws {
        
        var charactersList: CharacterListDO!
        let error: Error? = nil
        let expectation = self.expectation(description: "Get transactions")
        
        interactor.getCharacters(page: nil)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
                
                expectation.fulfill()
            }, receiveValue: { value in
                charactersList = value
            })
            .store(in: &disposables)
        
        wait(for: [expectation], timeout: 10)
        XCTAssertNil(error)
        XCTAssertEqual(charactersList.results.count, 20)
        XCTAssertTrue(charactersList.results[0].name.contains("Rick Sanchez"))
    }
}

private enum CharactersResponseFactory {

    static func makeCharactersResponse() -> CharacterListDO {

        let character1 = CharacterDO(id: 1, name: "Rick Sanchez", status: .alive, species: "Human", type: "Mad scientist", gender: "Male", origin: CharacterDO.LocationCharacterDO(name: "Earth", url: ""), location: CharacterDO.LocationCharacterDO(name: "Citadel of Ricks", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", episode: ["https://rickandmortyapi.com/api/episode/1"], url: "https://rickandmortyapi.com/api/character/1", created: "2017-11-04T18:48:46.250Z")
        let character2 = CharacterDO(id: 2, name: "Morty Smith", status: .alive, species: "Human", type: "", gender: "Male", origin: CharacterDO.LocationCharacterDO(name: "Earth", url: ""), location: CharacterDO.LocationCharacterDO(name: "Citadel of Ricks", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", episode: ["https://rickandmortyapi.com/api/episode/1"], url: "https://rickandmortyapi.com/api/character/2", created: "2017-11-04T18:50:21.651Z")
        let character3 = CharacterDO(id: 3, name: "Summer Smith", status: .alive, species: "Human", type: "", gender: "Female", origin: CharacterDO.LocationCharacterDO(name: "Earth", url: ""), location: CharacterDO.LocationCharacterDO(name: "Citadel of Ricks", url: ""), image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg", episode: ["https://rickandmortyapi.com/api/episode/6"], url: "https://rickandmortyapi.com/api/character/3", created: "2017-11-04T19:09:56.428Z")
        return CharacterListDO(
            info: InfoDO(count: 3, pages: 3, next: "https://rickandmortyapi.com/api/character/?page=3", prev: "https://rickandmortyapi.com/api/character/?page=1"),
            results: [
                character1,
                character2,
                character3
            ]
        )
    }
}
