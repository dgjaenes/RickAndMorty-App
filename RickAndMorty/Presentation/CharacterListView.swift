//
//  CharacterListView.swift
//  RickAndMorty
//

import SwiftUI

struct CharacterListView: View {

    @ObservedObject var viewModel = CharacterListViewModel(characterInteractor: InteractorProvaider.getCharactersInteractor())
    var body: some View {
            VStack(alignment: .leading) {
                searchField
                    .padding(.leading, 20)
                List {
                    Section(header: Text("Characters")) {
                        ForEach(viewModel.characters, id: \.id) { character in
                            NavigationLink(destination: CharacterDetail(character: character)) {
                                CharacterCardView(character: character)
                            }
                            .listRowBackground(Color.black)
                            .buttonStyle(PlainButtonStyle())
                            .foregroundColor(.white)
                        }
                    }
                }
                .onAppear {
                    viewModel.name = ""
                    initView()
                }
            }
    }

    private func initView() {
        viewModel.initView()
    }
}

private extension CharacterListView {
    
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("example: Morty, Smith, Lincler ...", text: $viewModel.name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
