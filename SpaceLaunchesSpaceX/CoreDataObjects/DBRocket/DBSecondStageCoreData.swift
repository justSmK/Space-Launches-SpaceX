//
//  DBSecondStageCoreData.swift
//  SpaceLaunchesSpaceX
//
//  Created by justSmK on 8/3/22.
//

import Foundation
import CoreData

@objc(DBSecondStage)
public class DBSecondStage: NSManagedObject, Decodable {
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoContext = CodingUserInfoKey.context else {
            fatalError()
        }
        guard let context = decoder.userInfo[codingUserInfoContext] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "DBSecondStage", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.engines = try container.decodeIfPresent(Int32.self, forKey: .engines) ?? 0
        self.burnTime = try container.decodeIfPresent(Double.self, forKey: .burnTime) ?? 0
        self.fuelAmountTons = try container.decodeIfPresent(Double.self, forKey: .fuelAmountTons) ?? 0
        
    }
    
    enum CodingKeys: String, CodingKey {
        case engines = "engines"
        case fuelAmountTons = "fuel_amount_tons"
        case burnTime = "burn_time_sec"
    }
}

extension DBSecondStage {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBSecondStage> {
        return NSFetchRequest<DBSecondStage>(entityName: "DBSecondStage")
    }
    
    @NSManaged public var burnTime: Double
    @NSManaged public var engines: Int32
    @NSManaged public var fuelAmountTons: Double
    @NSManaged public var rocket: DBRocket?
    
}

extension DBSecondStage : Identifiable {
    
}
