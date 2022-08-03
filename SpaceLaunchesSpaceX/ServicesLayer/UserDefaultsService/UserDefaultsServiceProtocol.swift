//
//  UserDefaultsServiceProtocol.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation

protocol UserDefaultsServiceProtocol {
    func saveForKey(text: String, key: String)
    func getForKey(key: String) -> String?
}
