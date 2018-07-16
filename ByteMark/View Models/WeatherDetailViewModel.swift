//
//  WeatherDetailViewModel.swift
//  ByteMark
//
//  Created by Amardeep Kaur on 15/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//

import UIKit

class WeatherDetailViewModel: NSObject {
    // MARK: - Properties
    var allCities:[City]?
    
    override init() {
        super.init()
        self.prepareData()
    }
    
    func prepareData() {
        self.allCities = DataManager.fetchAllCities()
    }
    
    func numberOfSections() -> Int {
        return self.allCities?.count ?? 0
    }
    
    func numberOfRowsForSection(iSectionIndex: Int) -> Int {
        if let allTheCities = self.allCities, allTheCities.count > 0 {
            let theCity = allTheCities[iSectionIndex]
            
            return theCity.temperatures?.allObjects.count ?? 0
        }
        
        return 0
    }
    
    func actualTempForHeader(iSectionIndex: Int) -> String {
        var temp = ""
        if let allTheCities = self.allCities, allTheCities.count > 0 {
            let theCity = allTheCities[iSectionIndex]
            let theTemperatures = theCity.temperatures?.allObjects
            let theTemperature: Temperature = theTemperatures?[0] as! Temperature
            temp = theTemperature.actualTemperature ?? ""
        }
        return temp
    }
    
    func titleForSection(iSectionIndex: Int) -> String {
        var title = ""
        if let allTheCities = self.allCities, allTheCities.count > 0 {
            let theCity = allTheCities[iSectionIndex]
            title = theCity.name ?? ""
        }
        return title
    }
    
    func dateForHeader(iSectionIndex: Int) -> String {
        var dateStr = ""
        if let allTheCities = self.allCities, allTheCities.count > 0 {
            let theCity = allTheCities[iSectionIndex]
            let theTemperatures = theCity.temperatures?.allObjects
            let theTemperature: Temperature = theTemperatures?[0] as! Temperature
            if let date = theTemperature.temperatureDateString {
                let dateString = formattedDate(dateString: date)
                dateStr = dateString
            }
        }
        return dateStr
    }
    
    func formattedDate(dateString: String) -> String {
        var theDateString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MM-dd-yyyy"
            theDateString = dateFormatter.string(from: date)
        }
        return theDateString
    }
    
    func fetchWeatherInfoItemForIndexPath(iIndexPath: IndexPath) -> WeatherTableCellViewModel {
        var theWeatherTableViewCellViewModel: WeatherTableCellViewModel?
        
        if let allTheCities = self.allCities, allTheCities.count > 0 {
            let theCity = allTheCities[iIndexPath.section]
            if let theTemperatures = theCity.temperatures, theTemperatures.allObjects.count > 0, let theTemperature = theTemperatures.allObjects[iIndexPath.row] as? Temperature {
                theWeatherTableViewCellViewModel = WeatherTableCellViewModel.init(iTemperature: theTemperature)
                return theWeatherTableViewCellViewModel!
            }
        }
        
        return theWeatherTableViewCellViewModel!
    }
}

class WeatherTableCellViewModel {
    var dateString: String {
        var theDateString = ""
        if let date = self.temperature.temperatureDateString {
            let dateString = self.formattedDate(dateString: date)
            theDateString = dateString
        }
        
        return theDateString
    }
    
    func formattedDate(dateString: String) -> String {
        var theDateString = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MM-dd-yyyy"
            theDateString = dateFormatter.string(from: date)
        }
        return theDateString
    }
    
    var maximumTemperature: String {
        return self.temperature.maximumTemperature ?? ""
    }
    
    var minimumTemperature: String {
        return self.temperature.minimumTemperature ?? ""
    }
    
    var weatherDescription: String {
        return self.temperature.weatherDescription ?? ""
    }
    
    private var temperature: Temperature
    
    init(iTemperature: Temperature) {
        self.temperature = iTemperature
    }
}
