//
//  ProfileAvatarView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 30/01/2025.
//

import SwiftUI

struct ProfileAvatarView: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 72, height: 72)
                .clipShape(Circle())
                .foregroundStyle(Color(UIColor.systemGray5))
                .overlay(
                    Circle()
                        .fill(.white)
                        .frame(width: 24, height: 24)  // Slightly larger than the plus button
                        .offset(x: 1, y: 1),
                    alignment: .bottomTrailing
                )

            Button(action: {
                // Add your action here
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.black)
                    .background(Color.white)
                    .clipShape(Circle())
            }
            .offset(x: -0.5, y: -0.5)
        }
    }
}

#Preview {
    ProfileAvatarView()
}
