//
//  LocationCardView.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 16/4/24.
//

import SwiftUI

struct LocationCardView: View {
    let location: LocationDO
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 10) {
                Text(location.name)
                    .font(.headline)
                HStack(spacing: 5) {
                    Text("Dimension:")
                        .font(.headline)
                    Text(location.dimension)
                        .font(.subheadline)
                }
                Text("Created:")
                    .font(.headline)
                Text(location.created)
                    .font(.subheadline)
                HStack {
                    Text("Type:")
                        .font(.headline)
                    Text(location.type)
                        .font(.subheadline)
                }
                HStack {
                    Text("Residents:")
                        .font(.headline)
                    Text(String(location.residents.count))
                        .font(.subheadline)
                }
            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
        }
    }
}

