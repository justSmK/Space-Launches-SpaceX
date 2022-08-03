//
//  RocketsViewProtocol.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 7/30/22.
//

import Foundation

protocol RocketsViewProtocol: AnyObject {
    func updateValues()
    func reloadCollectionViewCell(indexPaths: [IndexPath])
}
