//
//  NetworkingServiceProtocol.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 7/30/22.
//

import Foundation

protocol NetworkingServiceProtocol {
    func fetchFromUrl(
        url: URL,
        successComplete: @escaping (Data) -> Void,
        failure: @escaping (Error?) -> Void
    )
}
