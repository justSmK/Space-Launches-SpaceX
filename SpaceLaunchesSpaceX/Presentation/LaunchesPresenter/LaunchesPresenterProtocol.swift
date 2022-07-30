//
//  LaunchesPresenterProtocol.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 7/30/22.
//

import Foundation

protocol LaunchesPresenterProtocol {
    var view: LaunchesViewProtocol? { get set }
    func getLaunchDescription(for index: Int) -> (name: String,
                                                  date: String,
                                                  isSuccess: Bool)
    func getLaunchesCount() -> Int
}
