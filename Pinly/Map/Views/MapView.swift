//
//  MapView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 01/02/2025.
//

import SwiftUI
import MapboxMaps

struct MapView: View {
    var body: some View {
        let center = CLLocationCoordinate2D(latitude: 39.5, longitude: -98.0)
        Map(initialViewport: .camera(center: center, zoom: 2, bearing: 0, pitch: 0))
            .ignoresSafeArea()
    }
}

#Preview {
    MapView()
}
