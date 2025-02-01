//
//  EditProfileView.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 01/02/2025.
//

import SwiftUI

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: ProfileEditViewModel
    @State private var showingImagePicker = false
    
    init(profile: Profile, profileViewModel: ProfileViewModel) {
        _viewModel = State(wrappedValue: ProfileEditViewModel(
            profile: profile,
            profileViewModel: profileViewModel
        ))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Spacer()
                VStack(spacing: 8) {
                    if viewModel.form.shouldRemoveAvatar {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                            .foregroundStyle(Color(.systemGray4))
                    } else if let image = viewModel.form.selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())
                    } else {
                        ProfileAvatarView(
                            avatarUrl: viewModel.form.avatarUrl,
                            size: 64,
                            showEditButton: false
                        )
                    }
                    
                    Button(action: { showingImagePicker = true }) {
                        Text("Add or edit picture")
                            .font(.subheadline)
                            .foregroundStyle(Color.primary)
                    }
                    .padding(.top, 4)
                }
                Spacer()
            }
            .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Username")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                TextField("", text: $viewModel.form.username)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding(.vertical, 8)
                Divider()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Full Name")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                TextField("", text: $viewModel.form.fullName)
                    .padding(.vertical, 8)
                Divider()
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text("Bio")
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                TextField("", text: $viewModel.form.bio, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(3...6)
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    await viewModel.saveChanges()
                    dismiss()
                }
            }) {
                Text("Save Changes")
                    .font(.subheadline)
                    .foregroundStyle(Color(.systemBackground))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(Color.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .opacity(viewModel.form.hasChanges ? 1.0 : 0.5)
            }
            .disabled(!viewModel.form.hasChanges)
            .buttonStyle(.plain)
            .padding(.bottom)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.primary)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(
                selectedImage: $viewModel.form.selectedImage,
                shouldRemoveAvatar: $viewModel.form.shouldRemoveAvatar,
                hasExistingImage: viewModel.form.selectedImage != nil || viewModel.form.avatarUrl != nil
            )
            .presentationDetents([.height(viewModel.form.selectedImage != nil || viewModel.form.avatarUrl != nil ? 164 : 120)])
                .presentationDragIndicator(.visible)
                .presentationBackground(Color(.systemBackground))
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView(
            profile: Profile.mock,
            profileViewModel: ProfileViewModel()
        )
    }
}
