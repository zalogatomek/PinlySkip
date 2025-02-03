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
    var centerCoordinate: LocationCoordinate?
    var zoomLevel: Double?
    
    init(name: String, category: String) {
        self.id = UUID().uuidString
        self.name = name
        self.category = category
        self.markers = []
        self.createdAt = Date()
        self.centerCoordinate = nil
        self.zoomLevel = nil
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
    
    var toCLLocationCoordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension CustomMap {
    static let preview = CustomMap(name: "My First Map", category: "Travel")
    
    mutating func updateMapPosition(coordinate: CLLocationCoordinate2D?, zoom: Double?) {
        self.centerCoordinate = coordinate.map { LocationCoordinate(latitude: $0.latitude, longitude: $0.longitude) }
        self.zoomLevel = zoom
    }
}
