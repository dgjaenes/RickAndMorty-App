//
//  LocationsListView.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 16/4/24.
//

import SwiftUI

struct LocationsListView: View {
    
    @ObservedObject var viewModel = LocationListViewModel(locationInteractor: InteractorProvaider.getLocationsInteractor())
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("home")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100.0, height: 100.0)
                Text("Rick and Morty")
                    .font(.title)
                    .foregroundColor(.black)
            }
            searchField
                .padding(.leading, 20)
            listLocations
        }
    }
    
    private func initView() {
        viewModel.initView()
    }
}

private extension LocationsListView {
    
    var searchField: some View {
        HStack(alignment: .center) {
            TextField("example: Anatomy Park, Earth, Citadel of Ricks ...", text: $viewModel.name)
                .padding(.trailing, 15.0)
        }
    }
    
    var listLocations: some View {
        List {
            Section(header: Text("Locations")
                .padding(.top, 10)) {
                ForEach(viewModel.locations, id: \.id) { location in
                    NavigationLink(destination: CharacterLocationListView(location: location)) {
                        LocationCardView(location: location)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .listRowBackground(Color.black)
                    .foregroundColor(.white)
                    .listRowSeparatorTint(Color.white)
                    .listRowSeparator(.visible)
                }
            }
        }
        .onAppear {
            viewModel.name = ""
            initView()
        }
    }
}

struct LocationsListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsListView()
    }
}

