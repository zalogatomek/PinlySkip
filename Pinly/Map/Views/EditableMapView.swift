//
//  EditableMapView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 02/02/2025.
//

import SwiftUI
import MapboxMaps

struct EditableMapView: View {
    let map: CustomMap
    @Environment(\.dismiss) private var dismiss
    let onSave: (CustomMap) -> Void
    
    var body: some View {
        let center = CLLocationCoordinate2D(latitude: 39.5, longitude: -98.0)
        Map(initialViewport: .camera(center: center, zoom: 2, bearing: 0, pitch: 0))
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color(.systemBackground))
                            .background(Color.primary)
                            .clipShape(Circle())
                    }
                    Spacer()
                    Button(action: {
                        onSave(map)
                        dismiss()
                    }) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Color(.systemBackground))
                            .background(Color.primary)
                            .clipShape(Circle())
                    }
                }
                .padding()
            }
    }
}
