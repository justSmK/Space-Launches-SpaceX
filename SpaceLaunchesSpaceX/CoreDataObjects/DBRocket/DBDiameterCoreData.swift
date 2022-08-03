//
//  DBDiameterCoreData.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation
import CoreData

@objc(DBDiameter)
public class DBDiameter: NSManagedObject, Decodable {
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoContext = CodingUserInfoKey.context else {
            fatalError()
        }
        guard let context = decoder.userInfo[codingUserInfoContext] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "DBDiameter", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.meters = try container.decodeIfPresent(Double.self, forKey: .meters) ?? 0
        self.feet = try container.decodeIfPresent(Double.self, forKey: .feet) ?? 0
        
    }
    
    enum CodingKeys: String, CodingKey {
        case meters = "meters"
        case feet = "feet"
    }
}

extension DBDiameter {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBDiameter> {
        return NSFetchRequest<DBDiameter>(entityName: "DBDiameter")
    }
    
    @NSManaged public var meters: Double
    @NSManaged public var feet: Double
    @NSManaged public var rocket: DBRocket?
    
}

extension DBDiameter : Identifiable {
    
}
