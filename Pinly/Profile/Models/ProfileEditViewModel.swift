//
//  ProfileEditViewModel.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 01/02/2025.
//

import Foundation
import UIKit
import Observation

@Observable
final class ProfileEditViewModel {
    var form: ProfileForm
    private(set) var isLoading = false
    private(set) var error: Error?
    
    private let profileViewModel: ProfileViewModel
    private let service: ProfileServiceProtocol
    
    init(profile: Profile, profileViewModel: ProfileViewModel, service: ProfileServiceProtocol = ProfileService()) {
        self.form = ProfileForm(profile: profile)
        self.profileViewModel = profileViewModel
        self.service = service
    }
    
    func saveChanges() async {
        isLoading = true
        error = nil
        
        do {
            let imageUrl: String?
            if form.shouldRemoveAvatar {
                if let currentAvatarUrl = form.avatarUrl {
                    UserDefaults.standard.removeObject(forKey: currentAvatarUrl)
                }
                imageUrl = nil
            } else if let image = form.selectedImage {
                let imageKey = "avatar_\(UUID().uuidString)"
                if let imageData = image.jpegData(compressionQuality: 0.9) {
                    UserDefaults.standard.set(imageData, forKey: imageKey)
                    imageUrl = imageKey
                } else {
                    imageUrl = nil
                }
            } else {
                imageUrl = form.avatarUrl
            }
            
            let updatedForm = ProfileForm(
                username: form.username,
                fullName: form.fullName,
                bio: form.bio,
                avatarUrl: imageUrl
            )
            
            _ = try await service.updateProfile(updatedForm)
            await profileViewModel.loadProfile()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
