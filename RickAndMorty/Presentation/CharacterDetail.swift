//
//  CharacterCard.swift
//  RickAndMorty
//

import SwiftUI
import Firebase

struct CharacterDetail: View {
    var character: CharacterDO
    @State private var image: UIImage? = nil
    
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
            ZStack {
                LinearGradient(
                    gradient: Gradient(
                        colors: [Color.white, Color.black]),
                    startPoint: .top,
                    endPoint: .bottom)
                .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 10.0) {
                    HStack {
                        getImage()
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .background(Color.gray.opacity(0.4))
                            .frame(width: 120, height: 120)
                            .cornerRadius(8)
                            .padding(6)
                        VStack(alignment: .leading, spacing: 10) {
                            Text(character.name)
                                .font(.title)
                                .foregroundColor(.white)
                            HStack(spacing: 5) {
                                Circle()
                                    .fill(character.status == .alive ? Color.green : Color.red)
                                    .frame(width: 10, height: 10)
                                Text(character.status.rawValue)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                            }
                            Text(character.species)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text(character.gender)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text(character.type)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Text("Last seen in: \n \(character.location.name)")
                                .font(.headline)
                                .foregroundColor(.white)
                            Text("Total episodes: \n \(character.episode.count)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .background(Color.gray.opacity(0.8))
                        .cornerRadius(6)
                    }
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(6)
                    .padding(6)
                }
            }
            .onAppear {
                loadImage()
                Analytics.logEvent("link_character", parameters: ["character": character])
            }
        }
    }
    
    private func loadImage() {
        if let imageUrl = URL(string: character.image) {
            UIImage.download(from: imageUrl) { (image) in
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
    
    private func getImage() -> Image {
        return Image(uiImage: image ?? UIImage(systemName: "person.fill")!)
    }
}
