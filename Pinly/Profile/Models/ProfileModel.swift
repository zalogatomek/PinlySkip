//
//  ProfileModel.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 01/02/2025.
//

import Foundation

struct ProfileModel: Codable {
    let username: String
    let fullName: String
    let bio: String
    let avatarUrl: String?
}
