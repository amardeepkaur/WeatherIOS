//
//  City+CoreDataClass.swift
//  ByteMark
//
//  Created by Amardeep on 15/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

@objc(City)
public class City: NSManagedObject {
    class func newObjectCity(iCityDetails: [AnyHashable: Any]) -> City {
        let theAppDelegate = UIApplication.shared.delegate as? AppDelegate
        let theCity: City = NSManagedObject.init(entity: (theAppDelegate?.persistentContainer.managedObjectModel.entitiesByName["City"])!, insertInto: theAppDelegate?.persistentContainer.viewContext) as! City
        
        if let theCityDetails = iCityDetails["city"] as? [AnyHashable: AnyHashable] {
            theCity.id = "\(String(describing: theCityDetails["id"] as? Int))"
            theCity.name = theCityDetails["name"] as? String
        }
        
        if let theWeatherList = iCityDetails["list"] as? [Any], theWeatherList.count > 0 {
            let aSetOfWeatherInfo = theCity.mutableOrderedSetValue(forKey: "temperatures")//theCity.mutableSetValue(forKey: "temperatures")
            
            var thePreviousDateString = ""
            for aWeatherInfo in theWeatherList {
                if let theWeatherInfoValue = aWeatherInfo as? [AnyHashable: Any] {
                    let theCurrentTemperature = theWeatherInfoValue["dt_txt"] as? String
                    if City.isDateSame(iCurrentDateString: theCurrentTemperature ?? "", iPreviousDateString: thePreviousDateString) == false {
                        let temperature: Temperature = Temperature.newObjectTemperature(iCityDetails: theWeatherInfoValue, andCity: theCity)
                        aSetOfWeatherInfo.add(temperature)
                        thePreviousDateString = temperature.temperatureDateString!
                    }
                }
            }
        }
        
        return theCity
    }
    
    private class func isDateSame(iCurrentDateString: String, iPreviousDateString: String) -> (Bool) {
        var theSplitArray = iCurrentDateString.split(separator: " ")
        var theCurrentDateStringModified = ""
        if theSplitArray.count > 0 {
            theCurrentDateStringModified = String(theSplitArray[0])
        }
        
        theSplitArray = iPreviousDateString.split(separator: " ")
        var thePreviousDateStringModified = ""
        if theSplitArray.count > 0 {
            thePreviousDateStringModified = String(theSplitArray[0])
        }
        
        if theCurrentDateStringModified == thePreviousDateStringModified {
            return true
        }
        
        return false
    }
}
