//
//  File.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 16/4/24.
//

import Foundation

struct LocationListDO: Codable {
    let info: Info
    let results: [LocationDO]

    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
