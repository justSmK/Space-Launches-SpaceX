//
//  Rocket.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 7/30/22.
//

import Foundation

struct Rocket: Codable {
    let id: String
    let name: String
    let height: Height
    let mass: Mass
    let first_stage: Stage
    let second_stage: Stage
    let payload_weight: [PayloadWeight]
    let cost_per_launch: Int
    let first_flight: String
    let country: String
    let flickr_images: [String]
}

struct Height: Codable {
    let meters: Double
    let feet: Double
}

struct Diameter: Codable {
    let meters: Double
    let feet: Double
}

struct Mass: Codable {
    let kg: Double
    let lb: Double
}

struct Stage: Codable {
    let engines: Int
    let fuel_amount_tons: Double
    let burn_time_sec: Double?
}

struct PayloadWeight: Codable {
    let id: String
    let name: String
    let kg: Int
    let lb: Int
}
