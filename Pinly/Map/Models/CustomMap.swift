//
//  CustomMap.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 02/02/2025.
//

import Foundation
import CoreLocation

struct CustomMap: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let category: String
    var markers: [MapMarker]
    let createdAt: Date
    
    init(name: String, category: String) {
        self.id = UUID().uuidString
        self.name = name
        self.category = category
        self.markers = []
        self.createdAt = Date()
    }
    
    static func == (lhs: CustomMap, rhs: CustomMap) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct MapMarker: Codable, Identifiable {
    let id: String
    let coordinate: LocationCoordinate
    
    init(coordinate: CLLocationCoordinate2D) {
        self.id = UUID().uuidString
        self.coordinate = LocationCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
}

struct LocationCoordinate: Codable {
    let latitude: Double
    let longitude: Double
}

extension CustomMap {
    static let preview = CustomMap(name: "My First Map", category: "Travel")
}
