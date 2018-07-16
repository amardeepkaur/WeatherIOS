//
//  Temperature+CoreDataClass.swift
//  ByteMark
//
//  Created by Amardeep on 15/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(Temperature)
public class Temperature: NSManagedObject {
    class func newObjectTemperature(iCityDetails: [AnyHashable: Any], andCity iCity: City) -> Temperature {
        let theAppDelegate = UIApplication.shared.delegate as? AppDelegate
        let theTemperature: Temperature = NSManagedObject.init(entity: (theAppDelegate?.persistentContainer.managedObjectModel.entitiesByName["Temperature"])!, insertInto: theAppDelegate?.persistentContainer.viewContext) as! Temperature
        
        theTemperature.temperatureDate = iCityDetails["dt"] as? NSDate
        theTemperature.temperatureDateString = iCityDetails["dt_txt"] as? String
        theTemperature.city = iCity
        
        if let theMainDetails = iCityDetails["main"] as? [AnyHashable: Any] {
            
            if let kelvinTemp = theMainDetails["temp"] as? Double {
                let celsiusTemp = kelvinTemp - 273.15
                theTemperature.actualTemperature = String(format: "%.0f", celsiusTemp)
            }

            if let kelvinTemp = theMainDetails["temp_max"] as? Double {
                let celsiusTemp = kelvinTemp - 273.15
                theTemperature.maximumTemperature = String(format: "%.0f", celsiusTemp)
            }

            if let kelvinTemp = theMainDetails["temp_min"] as? Double {
                let celsiusTemp = kelvinTemp - 273.15
                theTemperature.minimumTemperature = String(format: "%.0f", celsiusTemp)
            }
        }
        
        if let theWeatherArray = iCityDetails["weather"] as? [Any], theWeatherArray.count > 0, let theWeatherDetails = theWeatherArray[0] as? [AnyHashable: Any] {
            theTemperature.weatherDescription = theWeatherDetails["description"] as? String
        }
        
        return theTemperature
    }
}
