//
//  MainView.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 13/4/24.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        NavigationView {
            VStack {
                Text("Rick and Morty")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    .padding()
                
                NavigationLink(destination: CharacterListView()) {
                    ZStack {
                        Image("characters")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Characters")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .padding()
                            .shadow(color: .gray, radius: 5, x: 3, y: 3)
                    }
                }
                
                NavigationLink(destination: CharacterListView()) {
                    ZStack {
                        Image("locations")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Locations")
                            .font(.largeTitle.bold())
                            .foregroundColor(.white)
                            .padding()
                            .shadow(color: .gray, radius: 5, x: 3, y: 3)
                    }
                }
            }
            .background(Color.black)
        }
    }
}

