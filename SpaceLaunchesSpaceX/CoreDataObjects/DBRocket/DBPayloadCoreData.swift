//
//  DBPayloadCoreData.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation
import CoreData

@objc(DBPayload)
public class DBPayload: NSManagedObject, Decodable {
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoContext = CodingUserInfoKey.context else {
            fatalError()
        }
        guard let context = decoder.userInfo[codingUserInfoContext] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "DBPayload", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.kg = try container.decodeIfPresent(Int32.self, forKey: .kg) ?? 0
        self.lb = try container.decodeIfPresent(Int64.self, forKey: .lb) ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case kg = "kg"
        case lb = "lb"
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

extension DBPayload {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBPayload> {
        return NSFetchRequest<DBPayload>(entityName: "DBPayload")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var kg: Int32
    @NSManaged public var lb: Int64
    @NSManaged public var rocket: DBRocket?
    
}

extension DBPayload : Identifiable {
    
}
