//
//  Launch.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 7/30/22.
//

import Foundation

struct Launch: Codable {
    let id: String
    let rocket: String
    let success: Bool?
    let name: String
    let date_utc: String
}
