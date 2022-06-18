//
//  TouristDatabase+CoreDataProperties.swift
//  BirlaSoft_Assignment
//
//  Created by Krishna Gunjal on 17/06/22.
//
//

import Foundation
import CoreData


extension TouristDatabase {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TouristDatabase> {
        return NSFetchRequest<TouristDatabase>(entityName: "TouristDatabase")
    }

    @NSManaged public var createdDate: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var location: String?
    @NSManaged public var name: String?

}

extension TouristDatabase : Identifiable {

}
