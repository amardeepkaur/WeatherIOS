//
//  City+CoreDataProperties.swift
//  ByteMark
//
//  Created by Amardeep on 15/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var temperatures: NSSet?

}

// MARK: Generated accessors for temperatures
extension City {

    @objc(addTemperaturesObject:)
    @NSManaged public func addToTemperatures(_ value: Temperature)

    @objc(removeTemperaturesObject:)
    @NSManaged public func removeFromTemperatures(_ value: Temperature)

    @objc(addTemperatures:)
    @NSManaged public func addToTemperatures(_ values: NSSet)

    @objc(removeTemperatures:)
    @NSManaged public func removeFromTemperatures(_ values: NSSet)

}
