//
//  MapTileView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 02/02/2025.
//

import SwiftUI

struct MapTileView: View {
    let map: CustomMap
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            VStack(alignment: .leading, spacing: 8) {
                // Placeholder for map snapshot
                Rectangle()
                    .fill(Color(.systemGray5))
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(map.name)
                        .font(.system(size: 14, weight: .medium))
                    
                    Text(map.category)
                        .font(.system(size: 12))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 4)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    MapTileView(map: .preview) {}
}
