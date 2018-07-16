//
//  DataManager.swift
//  ByteMark
//
//  Created by Amardeep on 12/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//

import UIKit
import CoreData

class DataManager: NSObject {
    class func processCityData(withDetails iCityDetails: [AnyHashable: Any], andCompletionBlock iCompletion: ((_ iSucceed: Bool) -> ())) {
        let theAppDelegate = UIApplication.shared.delegate as? AppDelegate
        
        //DataManager.deleteAllCities()
        
        let _ = City.newObjectCity(iCityDetails: iCityDetails)
        theAppDelegate?.saveContext()
        
        iCompletion(true)
    }
    
    class func fetchAllCities() -> [City] {
        let theAppDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let theFetchRequest: NSFetchRequest<City> = City.fetchRequest()
        theFetchRequest.returnsObjectsAsFaults = false
        
        var allCities: [City] = [City]()
        
        do {
            allCities = (try theAppDelegate?.persistentContainer.viewContext.fetch(theFetchRequest))!
        } catch {
            
        }
        
        return allCities
    }
    
    class func deleteAllCities() {
        let theAppDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let allCities = DataManager.fetchAllCities()
        for aCity: City in allCities {
            theAppDelegate?.persistentContainer.viewContext.delete(aCity)
        }
        
        theAppDelegate?.saveContext()
    }

}
