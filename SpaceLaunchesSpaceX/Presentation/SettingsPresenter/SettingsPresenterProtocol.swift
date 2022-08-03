//
//  SettingsPresenterProtocol.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation

protocol SettingsPresenterProtocol {
    
    var view: SettingsViewProtocol? { get set }
    
    func heightValueChanged(currentValue: Int)
    func diameterValueChanged(currentValue: Int)
    func massValueChanged(currentValue: Int)
    func payloadsValueChanged(currentValue: Int)
    
    func getHeightSettings() -> Int
    func getDiameterSettings() -> Int
    func getMassSettings() -> Int
    func getPayloadsSettings() -> Int
}
