//
//  NetworkingService.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 7/30/22.
//

import Foundation

final class NetworkingService: NetworkingServiceProtocol {
    
    private let configuration: URLSessionConfiguration = .default
    private lazy var urlSession: URLSession = .init(configuration: configuration)
    
    init() {
        
    }
    
    public func fetchFromUrl(
        url: URL,
        successComplete: @escaping (Data) -> Void,
        failure: @escaping (Error?) -> Void
    ) {
        let request: URLRequest = .init(url: url)
        let dataTask = urlSession.dataTask(with: request) { data, response, error in
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                  let data = data,
                  error == nil
            else {
                failure(error)
                return
            }
            successComplete(data)
        }
        dataTask.resume()
    }
}
