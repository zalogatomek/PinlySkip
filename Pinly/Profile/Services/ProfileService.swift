//
//  ProfileService.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 30/01/2025.
//

import Foundation

protocol ProfileServiceProtocol {
    func fetchProfile() async throws -> Profile
    func updateProfile(_ form: ProfileForm) async throws -> Profile
}

final class ProfileService: ProfileServiceProtocol {
    private let defaults = UserDefaults.standard
    private let profileKey = "stored_profile"
    
    func fetchProfile() async throws -> Profile {
        // Try to fetch from UserDefaults first
        if let data = defaults.data(forKey: profileKey),
           let model = try? JSONDecoder().decode(ProfileModel.self, from: data) {
            return Profile(model: model)
        }
        
        // If no stored profile, return mock data
        try await Task.sleep(nanoseconds: 1_000_000_000)
        let profile = Profile(
            username: "jumpforest",
            fullName: "Pat Jumpforest",
            bio: "Just jumping around in a forest of code.",
            avatarUrl: nil
        )
        
        // Store the initial profile
        try storeProfile(profile)
        return profile
    }
    
    func updateProfile(_ form: ProfileForm) async throws -> Profile {
        try await Task.sleep(nanoseconds: 500_000_000) // Simulate network delay
        
        let profile = Profile(
            username: form.username,
            fullName: form.fullName,
            bio: form.bio,
            avatarUrl: form.avatarUrl
        )
        
        try storeProfile(profile)
        return profile
    }
    
    private func storeProfile(_ profile: Profile) throws {
        let model = ProfileModel(
            username: profile.username,
            fullName: profile.fullName,
            bio: profile.bio,
            avatarUrl: profile.avatarUrl
        )
        let data = try JSONEncoder().encode(model)
        defaults.set(data, forKey: profileKey)
    }
}

// MARK: - Errors
extension ProfileService {
    enum ProfileError: LocalizedError {
        case failedToFetchProfile
        case failedToUpdateProfile
        
        var errorDescription: String? {
            switch self {
            case .failedToFetchProfile:
                return "Failed to fetch profile. Please try again later."
            case .failedToUpdateProfile:
                return "Failed to update profile. Please try again later."
            }
        }
    }
}
