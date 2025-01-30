//
//  AuthenticationView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 30/01/2025.
//

import SwiftUI

struct AuthenticationView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Sign in to start sharing your world.")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            VStack(spacing: 15) {
                Button(action: {
                    // Handle Apple sign in
                }) {
                    HStack {
                        Image(systemName: "apple.logo")
                            .font(.title2)
                        Spacer()
                        Text("Continue with Apple")
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.black, lineWidth: 2)
                    )
                }
                
                Button(action: {
                    // Handle Google sign in
                }) {
                    HStack {
                        Image(systemName: "apple.logo")
                            .font(.title2)
                        Spacer()
                        Text("Continue with Google")
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.black, lineWidth: 2)
                    )
                }
                
                Button(action: {
                    // Handle Email sign in
                }) {
                    HStack {
                        Image(systemName: "envelope")
                            .font(.title2)
                        Spacer()
                        Text("Continue with Email")
                            .font(.system(size: 14, weight: .semibold))
                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 56)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: 28)
                            .stroke(Color.black, lineWidth: 2)
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    AuthenticationView()
}
