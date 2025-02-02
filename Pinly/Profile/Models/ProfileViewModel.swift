//
//  ProfileViewModel.swift
//  Pinly
//
//  Created by Patryk Skoczylas on 30/01/2025.
//

import Foundation

@Observable
final class ProfileViewModel {
    private(set) var profile: Profile?
    private(set) var maps: [CustomMap] = []
    private(set) var error: Error?
    private(set) var isLoading = false
    
    private let service: ProfileServiceProtocol
    private let mapService = MapService()
    
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
    
    func loadMaps() async {
        do {
            maps = try mapService.loadMaps()
        } catch {
            self.error = error
        }
    }
    
    func saveMap(_ map: CustomMap) async {
        do {
            if let index = maps.firstIndex(where: { $0.id == map.id }) {
                maps[index] = map  // Update existing map
            } else {
                maps.append(map)   // Add new map
            }
            try mapService.saveMaps(maps)
        } catch {
            self.error = error
        }
    }
}
