//
//  MainView.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 13/4/24.
//

import SwiftUI
import Firebase

struct MainView: View {

    var body: some View {
        NavigationView {
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
                VStack(alignment: .leading) {
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
                    
                    NavigationLink(destination: LocationsListView()) {
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
                .padding(.vertical, 25.0)
                .background(Color.black)
            }
            .navigationBarItems(trailing:
                            Button(action: {
                do {
                    try Auth.auth().signOut()
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first {
                        window.rootViewController = UIHostingController(rootView: AuthView())
                    }
                    Analytics.logEvent("close_sesion", parameters: nil)
                } catch {
                    Analytics.logEvent("error_close_sesion", parameters: nil)
                }
                            }) {
                                Image(uiImage: UIImage(systemName: "person.badge.minus.fill")!)
                            }
                        )
            
        }
        .accentColor(.black)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
