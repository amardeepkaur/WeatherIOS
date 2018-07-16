//
//  Temperature+CoreDataProperties.swift
//  ByteMark
//
//  Created by Amardeep on 15/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//
//

import Foundation
import CoreData


extension Temperature {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Temperature> {
        return NSFetchRequest<Temperature>(entityName: "Temperature")
    }

    @NSManaged public var actualTemperature: String?
    @NSManaged public var maximumTemperature: String?
    @NSManaged public var minimumTemperature: String?
    @NSManaged public var temperatureDate: NSDate?
    @NSManaged public var temperatureDateString: String?
    @NSManaged public var weatherDescription: String?
    @NSManaged public var city: City?

}
