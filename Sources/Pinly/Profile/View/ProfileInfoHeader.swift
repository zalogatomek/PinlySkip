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

    init(fullNameLabel: String, bioLabel: String) {
        self.fullNameLabel = fullNameLabel
        self.bioLabel = bioLabel
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .center, spacing: 12) {
                ProfileAvatarView()
                Text(fullNameLabel).font(.headline)
                Spacer()
            }
            Text(bioLabel)
                .font(.system(size: 14))
                .foregroundStyle(.secondary)
                .lineLimit(3)
                .padding(.bottom, 12)
            
            VStack(alignment: .leading) {
                HStack(spacing: 12) {
                    ProfileFlexButton(buttonTitle: "Edit Profile")
                    ProfileFlexButton(buttonTitle: "Share Profile")
                }
            }
        }
    }
}

#Preview {
    ProfileInfoHeader(fullNameLabel: "Patryk Skoczylas", bioLabel: "Hello, world!")
    
}
