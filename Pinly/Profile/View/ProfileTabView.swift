//
//  ProfileTabView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 30/01/2025.
//

import SwiftUI

struct ProfileTabView: View {
    @Binding var selectedMap: CustomMap?
    let maps: [CustomMap]
    @State private var selectedTab = 0
    
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Tab buttons
            HStack(spacing: 0) {
                TabButton(text: "Maps", isSelected: selectedTab == 0) {
                    selectedTab = 0
                }
                
                TabButton(text: "Interests", isSelected: selectedTab == 1) {
                    selectedTab = 1
                }
            }
            
            // Tab content
            TabView(selection: $selectedTab) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(maps, id: \.id) { map in
                            MapTileView(map: map) {
                                selectedMap = map
                            }
                        }
                    }
                    .padding()
                }
                .tag(0)
                
                Text("Interests Content")
                    .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }
}

struct TabButton: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Text(text)
                    .font(.subheadline)
                    .fontWeight(isSelected ? .semibold : .regular)
                    .foregroundStyle(isSelected ? .primary : .secondary)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundStyle(isSelected ? .primary : Color.clear)
            }
        }
        .frame(maxWidth: .infinity)
        .buttonStyle(.plain)
    }
}

#Preview {
    ProfileTabView(selectedMap: .constant(nil), maps: [])
}
