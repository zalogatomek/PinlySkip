//
//  MapServiceProtocol.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 02/02/2025.
//

import Foundation

protocol MapServiceProtocol {
    func saveMaps(_ maps: [CustomMap]) throws
    func loadMaps() throws -> [CustomMap]
}

final class MapService: MapServiceProtocol {
    private let defaults = UserDefaults.standard
    private let mapsKey = "user_maps"
    
    func saveMaps(_ maps: [CustomMap]) throws {
        let data = try JSONEncoder().encode(maps)
        defaults.set(data, forKey: mapsKey)
    }
    
    func loadMaps() throws -> [CustomMap] {
        guard let data = defaults.data(forKey: mapsKey) else { return [] }
        return try JSONDecoder().decode([CustomMap].self, from: data)
    }
}
