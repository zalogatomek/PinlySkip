//
//  ProfileViewModel.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 30/01/2025.
//

import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published private(set) var profile: Profile?
    @Published private(set) var error: Error?
    @Published private(set) var isLoading = false
    
    private let service: ProfileServiceProtocol
    
    init(service: ProfileServiceProtocol = ProfileService()) {
        self.service = service
    }
    
    func loadProfile() async {
        isLoading = true
        error = nil
        
        do {
            profile = try await service.fetchProfile()
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    func updateProfile(_ form: ProfileForm) async {
        isLoading = true
        error = nil
        
        do {
            profile = try await service.updateProfile(form)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
