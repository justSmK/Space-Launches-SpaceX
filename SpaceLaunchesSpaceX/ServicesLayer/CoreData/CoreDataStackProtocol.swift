//
//  CoreDataStackProtocol.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    func fetch<T>(fetchRequest: NSFetchRequest<T>) -> [T]
    func performSave (
        _ block: @escaping (NSManagedObjectContext) -> Void,
        successSave: @escaping () -> Void)
}
