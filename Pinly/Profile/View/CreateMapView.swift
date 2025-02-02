//
//  CreateMapView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 02/02/2025.
//

import SwiftUI

struct CreateMapView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var mapName = ""
    @State private var category = ""
    let onCreateMap: (CustomMap) -> Void
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Map Name")
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                    TextField("", text: $mapName)
                        .padding(.vertical, 8)
                    Divider()
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Category")
                        .font(.system(size: 13))
                        .foregroundStyle(.secondary)
                    TextField("", text: $category)
                        .padding(.vertical, 8)
                    Divider()
                }
                
                Spacer()
                
                Button(action: {
                    let newMap = CustomMap(name: mapName, category: category)
                    onCreateMap(newMap)
                    dismiss()
                }) {
                    Text("Create Map")
                        .font(.subheadline)
                        .foregroundStyle(Color(.systemBackground))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .opacity(mapName.isEmpty || category.isEmpty ? 0.5 : 1.0)
                }
                .disabled(mapName.isEmpty || category.isEmpty)
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Create New Map")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(Color.primary)
                    }
                }
            }
        }
    }
}
