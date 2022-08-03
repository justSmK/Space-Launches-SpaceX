//
//  DBMassCoreData.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation
import CoreData

@objc(DBMass)
public class DBMass: NSManagedObject, Decodable {
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoContext = CodingUserInfoKey.context else {
            fatalError()
        }
        guard let context = decoder.userInfo[codingUserInfoContext] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "DBMass", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.kg = try container.decodeIfPresent(Double.self, forKey: .kg) ?? 0
        self.lb = try container.decodeIfPresent(Double.self, forKey: .lb) ?? 0
        
    }
    
    enum CodingKeys: String, CodingKey {
        case kg = "kg"
        case lb = "lb"
    }
}

extension DBMass {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBMass> {
        return NSFetchRequest<DBMass>(entityName: "DBMass")
    }
    
    @NSManaged public var kg: Double
    @NSManaged public var lb: Double
    @NSManaged public var rocket: DBRocket?
    
}

extension DBMass : Identifiable {
    
}
