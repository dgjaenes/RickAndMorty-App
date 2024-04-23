//
//  LocationDO.swift
//  RickAndMorty
//
//  Created by David Gonzalez Jaenes on 16/4/24.
//

import Foundation

struct LocationDO: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
    
    func getIds() -> [Int] {
        var nums: [Int] = []
        for item in residents {
            if let url = URL(string: item) {
                let pathComponents = url.pathComponents
                if let lastPathComponent = pathComponents.last, let value = Int(lastPathComponent) {
                    nums.append(value)
                }
            }
        }
        return nums
    }
}
