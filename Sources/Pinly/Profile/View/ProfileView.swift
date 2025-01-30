//
//  ContentView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 29/01/2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 12) {
                ProfileInfoHeader(
                    fullNameLabel: "Patryk Skoczylas",
                    bioLabel: "Hello World"
                )
                .padding(.top, 16)
                .padding(.bottom, 24)
                .padding(.horizontal)
                
                ProfileTabView()
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("johndoe")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}
