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
    
    var body: some View {
        NavigationStack {
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
                        
                        ProfileTabView()
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
        .task {
            await viewModel.loadProfile()
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
