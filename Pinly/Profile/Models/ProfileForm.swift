//
//  ProfileForm.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 01/02/2025.
//

import Foundation

struct ProfileForm {
    var username: String
    var fullName: String
    var bio: String
    var avatarUrl: String?
    
    init(profile: Profile) {
        self.username = profile.username
        self.fullName = profile.fullName
        self.bio = profile.bio
        self.avatarUrl = profile.avatarUrl
    }
    
    init(username: String, fullName: String, bio: String, avatarUrl: String? = nil) {
        self.username = username
        self.fullName = fullName
        self.bio = bio
        self.avatarUrl = avatarUrl
    }
    
    static let empty = ProfileForm(
        username: "",
        fullName: "",
        bio: "",
        avatarUrl: nil
    )
}

