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
                    Text(location.dimension)
                        .font(.subheadline)
                }
                Text(location.created)
                    .font(.subheadline)
                Text(location.type)
                    .font(.subheadline)
                Text("Residents: " + String(location.residents.count))
                    .font(.subheadline)
            }
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .cornerRadius(6)
        }
        .cornerRadius(6)
        .padding(0)
    }
}

