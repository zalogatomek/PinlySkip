//
//  ProfileTabView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 30/01/2025.
//

import SwiftUI

struct ProfileTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        // Tab View
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
                Text("Maps Content")
                    .tag(0)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                Text("Interests Content")
                    .tag(1)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
    ProfileTabView()
}
