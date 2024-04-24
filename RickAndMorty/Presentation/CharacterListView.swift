//
//  CharacterListView.swift
//  RickAndMorty
//

import SwiftUI

struct CharacterListView: View {
    
    @ObservedObject var viewModel = ViewModelProvaider.viewModelListCharacter()
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("home")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0, height: 100.0)
                Text("RICK AND MORTY WORLD")
                    .font(.title)
                    .foregroundColor(.black)
            }
            searchField
                .padding(.leading, 20)
            listCharacters
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
    
    var listCharacters: some View {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
