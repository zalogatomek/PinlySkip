//
//  Profile.swift
//  Pinly
//

import Foundation

struct Profile: Codable {
    let username: String
    let fullName: String
    let bio: String
    let avatarUrl: String?
    
    static let mock = Profile(
        username: "jumpforest",
        fullName: "Patryk Skoczylas",
        bio: "Just jumping around in a forest of code.",
        avatarUrl: nil
    )
}
