//
//  ProfileFlexButton.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 30/01/2025.
//

import SwiftUI

struct ProfileFlexButton: View {
    var body: some View {
        Button(action: {}) {
            Text((buttonTitle))
                .font(.caption)
                .fontWeight(.medium)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 1)
                )
        }
    }
    var buttonTitle: String = "Title"
}

#Preview {
    ProfileFlexButton()
}
