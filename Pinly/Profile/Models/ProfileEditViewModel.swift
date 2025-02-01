//
//  ProfileEditViewModel.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 01/02/2025.
//

import Foundation
import UIKit

@MainActor
final class ProfileEditViewModel: ObservableObject {
    @Published var username: String
    @Published var fullName: String
    @Published var bio: String
    @Published var selectedImage: UIImage?
    @Published var shouldRemoveAvatar: Bool = false
    @Published private(set) var isLoading = false
    @Published private(set) var error: Error?
    
    private let profile: Profile
    private let profileViewModel: ProfileViewModel
    private let service: ProfileServiceProtocol
    
    var hasChanges: Bool {
        username != profile.username ||
        fullName != profile.fullName ||
        bio != profile.bio ||
        selectedImage != nil ||
        shouldRemoveAvatar
    }
    
    var avatarUrl: String? {
        profile.avatarUrl
    }
    
    init(profile: Profile, profileViewModel: ProfileViewModel, service: ProfileServiceProtocol = ProfileService()) {
        self.profile = profile
        self.profileViewModel = profileViewModel
        self.service = service
        
        self.username = profile.username
        self.fullName = profile.fullName
        self.bio = profile.bio
    }
    
    func saveChanges() async {
        isLoading = true
        error = nil
        
        do {
            let imageUrl: String?
            if shouldRemoveAvatar {
                if let currentAvatarUrl = profile.avatarUrl {
                    UserDefaults.standard.removeObject(forKey: currentAvatarUrl)
                }
                imageUrl = nil
            } else if let image = selectedImage {
                let imageKey = "avatar_\(UUID().uuidString)"
                if let imageData = image.jpegData(compressionQuality: 0.9) {
                    UserDefaults.standard.set(imageData, forKey: imageKey)
                    imageUrl = imageKey
                } else {
                    imageUrl = nil
                }
            } else {
                imageUrl = profile.avatarUrl
            }
            
            let form = ProfileForm(
                username: username,
                fullName: fullName,
                bio: bio,
                avatarUrl: imageUrl
            )
            
            _ = try await service.updateProfile(form)
            await profileViewModel.loadProfile()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
