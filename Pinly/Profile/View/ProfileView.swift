//
//  ContentView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 29/01/2025.
//

import SwiftUI

struct ProfileView: View {
    @State private var viewModel = ProfileViewModel()
    @State private var selectedTab = 0
    @State private var showingCreateMap = false
    @State private var showingEditableMap: CustomMap?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Group {
                    if let profile = viewModel.profile {
                        VStack(alignment: .leading, spacing: 12) {
                            ProfileInfoHeader(
                                fullNameLabel: profile.fullName,
                                bioLabel: profile.bio,
                                viewModel: viewModel
                            )
                            .padding(.top, 16)
                            .padding(.bottom, 24)
                            .padding(.horizontal)
                            
                            ProfileTabView(selectedMap: $showingEditableMap, maps: viewModel.maps)
                        }
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Text(profile.username)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                        }
                    } else if viewModel.isLoading {
                        ProgressView()
                    }
                }
                
                VStack {
                    Spacer()
                    Button(action: { showingCreateMap = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 54))
                            .foregroundStyle(Color.primary)
                            .background(Color(.systemBackground))
                            .clipShape(Circle())
                    }
                    .padding(.bottom, 24)
                }
            }
        }
        .sheet(isPresented: $showingCreateMap) {
            CreateMapView { newMap in
                Task {
                    await viewModel.saveMap(newMap)
                }
            }
        }
        .sheet(item: $showingEditableMap) { map in
            EditableMapView(map: map) { updatedMap in
                Task {
                    await viewModel.saveMap(updatedMap)
                }
            }
        }
        .task {
            await viewModel.loadProfile()
            await viewModel.loadMaps()
        }
        .alert("Error", isPresented: .constant(viewModel.error != nil), actions: {
            Button("OK") {}
        }, message: {
            if let error = viewModel.error {
                Text(error.localizedDescription)
            }
        })
    }
}

#Preview {
    ProfileView()
}
