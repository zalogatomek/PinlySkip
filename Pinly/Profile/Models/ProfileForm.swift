//
//  ProfileForm.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 01/02/2025.
//

import Foundation
import UIKit
import Observation

@Observable
final class ProfileForm {
    var username: String
    var fullName: String
    var bio: String
    var avatarUrl: String?
    var selectedImage: UIImage?
    var shouldRemoveAvatar: Bool = false
    
    var hasChanges: Bool {
        if let originalProfile = originalProfile {
            return username != originalProfile.username ||
                fullName != originalProfile.fullName ||
                bio != originalProfile.bio ||
                selectedImage != nil ||
                shouldRemoveAvatar
        }
        return true
    }
    
    private let originalProfile: Profile?
    
    init(profile: Profile) {
        self.username = profile.username
        self.fullName = profile.fullName
        self.bio = profile.bio
        self.avatarUrl = profile.avatarUrl
        self.originalProfile = profile
    }
    
    init(username: String, fullName: String, bio: String, avatarUrl: String? = nil) {
        self.username = username
        self.fullName = fullName
        self.bio = bio
        self.avatarUrl = avatarUrl
        self.originalProfile = nil
    }
    
    static let empty = ProfileForm(
        username: "",
        fullName: "",
        bio: "",
        avatarUrl: nil
    )
}

