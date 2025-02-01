//
//  ProfileAvatarView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 30/01/2025.
//

import SwiftUI

struct ProfileAvatarView: View {
    let avatarUrl: String?
    let size: CGFloat
    let showEditButton: Bool
    let action: (() -> Void)?
    
    init(avatarUrl: String? = nil, size: CGFloat = 72, showEditButton: Bool = false, action: (() -> Void)? = nil) {
        self.avatarUrl = avatarUrl
        self.size = size
        self.showEditButton = showEditButton
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 8) {
            Button(action: { action?() }) {
                if let avatarUrl = avatarUrl,
                   let data = UserDefaults.standard.data(forKey: avatarUrl),
                   let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                        .foregroundStyle(Color(.systemGray4))
                }
            }
            
            if showEditButton {
                Button(action: { action?() }) {
                    Text("Add or edit picture")
                        .font(.subheadline)
                        .foregroundStyle(Color.primary)
                }
                .padding(.top, 4)
            }
        }
    }
}

#Preview {
    ProfileAvatarView(avatarUrl: nil, size: 72, showEditButton: true, action: {})
}
