//
//  CharacterLocationListView.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 23/4/24.
//

import Foundation
import SwiftUI

struct CharacterLocationListView: View {

    private var location: LocationDO
    @ObservedObject var viewModel: CharacterLocationListViewModel
    
    init(location: LocationDO ) {
        self.location = location
        self.viewModel = CharacterLocationListViewModel(characterInteractor: InteractorProvaider.getCharactersInteractor(), location: self.location)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("home")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0, height: 100.0)
                Text("Residents of \(viewModel.name)")
                    .font(.title)
                    .foregroundColor(.black)
            }
            listCharacters
        }
    }
    
    private func initView() {
        viewModel.initView()
    }
}

private extension CharacterLocationListView {
    
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
            //viewModel.name = ""
            initView()
        }
    }
}
