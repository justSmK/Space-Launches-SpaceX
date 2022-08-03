//
//  DBLaunchCoreData.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation
import CoreData


@objc(DBLaunch)
public class DBLaunch: NSManagedObject, Decodable {
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoContext = CodingUserInfoKey.context else {
            fatalError()
        }
        guard let context = decoder.userInfo[codingUserInfoContext] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "DBLaunch", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success) ?? false
        self.rocket = try container.decodeIfPresent(String.self, forKey: .rocket)
        self.date = try container.decodeIfPresent(String.self, forKey: .date)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case rocket = "rocket"
        case success = "success"
        case name = "name"
        case date = "date_utc"
    }
}

extension DBLaunch {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBLaunch> {
        return NSFetchRequest<DBLaunch>(entityName: "DBLaunch")
    }
    
    @NSManaged public var rocket: String?
    @NSManaged public var success: Bool
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var date: String?
    
}

extension DBLaunch : Identifiable {
    
}
