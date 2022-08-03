//
//  UserDefaultsService.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation

final class UserDefaultsService: UserDefaultsServiceProtocol {
    
    private let defaults = UserDefaults.standard
    
    func saveForKey(text: String, key: String) {
        defaults.setValue(text, forKey: key)
    }
    
    func getForKey(key: String) -> String? {
        return defaults.string(forKey: key)
    }
}
