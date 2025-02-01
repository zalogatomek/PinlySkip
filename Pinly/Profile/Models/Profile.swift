//
//  Profile.swift
//  Pinly
//

import Foundation

struct Profile {
    let username: String
    let fullName: String
    let bio: String
    let avatarUrl: String?
    
    init(model: ProfileModel) {
        self.username = model.username
        self.fullName = model.fullName
        self.bio = model.bio
        self.avatarUrl = model.avatarUrl
    }
    
    init(username: String, fullName: String, bio: String, avatarUrl: String?) {
        self.username = username
        self.fullName = fullName
        self.bio = bio
        self.avatarUrl = avatarUrl
    }
    
    static let mock = Profile(
        username: "jumpforest",
        fullName: "Patryk Skoczylas",
        bio: "Just jumping around in a forest of code.",
        avatarUrl: nil
    )
}
