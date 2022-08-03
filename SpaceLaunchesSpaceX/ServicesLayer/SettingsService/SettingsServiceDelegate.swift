//
//  SettingsServiceDelegate.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation

protocol SettingsServiceDelegate: AnyObject {
    func heightSettingsChanged()
    func diameterSettingsChanged()
    func massSettingsChanged()
    func payloadsSettingsChanged()
}
