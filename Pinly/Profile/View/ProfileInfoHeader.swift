//
//  ProfileInfoHeader.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 30/01/2025.
//

import SwiftUI

struct ProfileInfoHeader: View {
    private let fullNameLabel: String
    private let bioLabel: String
    @State private var showingEditProfile = false
    @Bindable var viewModel: ProfileViewModel

    init(fullNameLabel: String, bioLabel: String, viewModel: ProfileViewModel) {
        self.fullNameLabel = fullNameLabel
        self.bioLabel = bioLabel
        self.viewModel = viewModel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top, spacing: 12) {
                ProfileAvatarView(avatarUrl: viewModel.profile?.avatarUrl)
                Text(fullNameLabel).font(.system(size: 14, weight: .medium))
                    .padding(.top, 8)
                Spacer()
            }
            Text(bioLabel)
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
                .lineLimit(6)
                .padding(.bottom, 12)
            
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    NavigationLink(destination: EditProfileView(
                        profile: viewModel.profile ?? Profile.mock,
                        profileViewModel: viewModel
                    )) {
                        ProfileFlexButton(buttonTitle: "Edit Profile")
                    }
                    .buttonStyle(.plain)
                    
                    Button(action: {
                        // Share action
                    }) {
                        ProfileFlexButton(buttonTitle: "Share Profile")
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

#Preview {
    ProfileInfoHeader(fullNameLabel: "Patryk Skoczylas", bioLabel: "Hello, world!", viewModel: ProfileViewModel())
    
}
