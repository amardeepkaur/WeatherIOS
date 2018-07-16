//
//  HomeViewModel.swift
//  ByteMark
//
//  Created by Amardeep on 12/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//

import UIKit

class HomeViewModel: NSObject, LocationManagerDelegate {
    
    // MARK: - Properties
    
    let screenTitle = "Home"
    let cityTextfieldPlaceHolder = "Enter city/cities name, comma separated !"
    let buttonTitle = "Search"
    
    var showAlertClosure: ((_ iTitle: String, _ iMessage: String, _ iCancelButtonTitle: String) -> ())?
    var handleDetailNavigationClosure: (() -> ())?
    
    // MARK: - Methods
    
    override init() {
        super.init()
    }
    
    func handleSearchButtonAction(iCityNames: String) {
        if iCityNames.isEmpty == true {
            self.showAlertClosure?("Error !", "The input field cannot be empty", "Ok")
        } else {
            let theDispatchGroup = DispatchGroup()
            let cities = iCityNames.split(separator: ",")
            DataManager.deleteAllCities()
            for aCity:Substring in cities {
                theDispatchGroup.enter()
                
                ServiceManager.fetchWeatherInformation(ForCity: String(aCity.trimmingCharacters(in: .whitespacesAndNewlines))) { (iSucceed) in
                   theDispatchGroup.leave()
                }
            }
            
            theDispatchGroup.notify(queue: .main) {
                let allTheCities = DataManager.fetchAllCities()
                for aCity: City in allTheCities {
                    print("City Details: \(aCity)")
                }
                
                self.handleDetailNavigationClosure?()
            }
        }
    }
    
    func handleCurrentLocationButtonAction() {
        let locationManager =  LocationManager.sharedManager
        locationManager.delegate = self
        locationManager.fetchCurrentCity()
    }
    
    // MARK: - LocationManager delegate methods
    
    func didUpdateLocation(iCurrentCity: String) {
        self.handleSearchButtonAction(iCityNames: iCurrentCity)
    }
}
