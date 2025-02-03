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
    @State private var showingSearch = false
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var viewport: Viewport
    
    init(map: CustomMap, onSave: @escaping (CustomMap) -> Void) {
        self.map = map
        self.onSave = onSave
        let initialCenter = CLLocationCoordinate2D(latitude: 39.5, longitude: -98.0)
        self._viewport = State(initialValue: .camera(center: initialCenter, zoom: 2, bearing: 0, pitch: 0))
    }
    
    var body: some View {
        Map(viewport: $viewport)
            .ignoresSafeArea()
            .overlay(alignment: .top) {
                VStack(spacing: 12) {
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundStyle(Color(.systemBackground))
                                .background(Color.primary)
                                .clipShape(Circle())
                        }
                        Spacer()
                        Button(action: { showingSearch = true }) {
                            Image(systemName: "magnifyingglass.circle.fill")
                                .font(.title2)
                                .foregroundStyle(Color(.systemBackground))
                                .background(Color.primary)
                                .clipShape(Circle())
                        }
                        Button(action: {
                            var updatedMap = map
                            updatedMap.centerCoordinate = selectedCoordinate.map { coordinate in
                                LocationCoordinate(latitude: coordinate.latitude, longitude: coordinate.longitude)
                            }
                            updatedMap.zoomLevel = 14
                            onSave(updatedMap)
                            dismiss()
                        }) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title2)
                                .foregroundStyle(Color(.systemBackground))
                                .background(Color.primary)
                                .clipShape(Circle())
                        }
                    }
                }
                .padding()
            }
            .sheet(isPresented: $showingSearch) {
                MapSearchView(selectedCoordinate: $selectedCoordinate)
                    .presentationDetents([.height(400)])
                    .presentationDragIndicator(.visible)
            }
            .onChange(of: selectedCoordinate) { oldValue, newCoordinate in
                if let coordinate = newCoordinate {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        viewport = .camera(center: coordinate, zoom: 14, bearing: 0, pitch: 0)
                    }
                }
            }
    }
}
