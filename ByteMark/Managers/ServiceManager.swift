//
//  ServiceManager.swift
//  ByteMark
//
//  Created by Amardeep on 12/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {
    class func fetchWeatherInformation(ForCities iCities: String, andCompletionBlock iCompletionBlock: @escaping ((_ iSucceed: Bool) -> ())) {
        let serviceManager = ServiceManager.init()
        serviceManager.fetchWeatherInformation(ForCities: iCities) { (iSucceed) in
            iCompletionBlock(iSucceed)
        }
    }
    
    private func fetchWeatherInformation(ForCities iCities: String, andCompletionBlock iCompletionBlock: @escaping ((_ iSucceed: Bool) -> ())) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(iCities)&appid=4cbb3c4f49e2b6722b7026dace4fdc98"
        let theURL = URL.init(string: urlString)
        
        RequestBuilder.sendRequest(withURL: theURL!, requestType: .POST) { (iSucceed, iData, iURLResponse) in
            if iSucceed {
                DispatchQueue.main.async {
                    let theParsedResponse = ResponseParser.parseResponse(iData: iData as! Data)
                    DataManager.processCityData(withDetails: theParsedResponse, andCompletionBlock: { (iSucceed) in
                        if iSucceed == true {
                            iCompletionBlock(true)
                        } else {
                            iCompletionBlock(false)
                        }
                    })
                }
            } else {
                iCompletionBlock(false)
            }
        }
    }
    
    class func fetchWeatherInformation(ForCity iCity: String, andCompletionBlock iCompletionBlock: @escaping ((_ iSucceed: Bool) -> ())) {
        let serviceManager = ServiceManager.init()
        serviceManager.fetchWeatherInformation(ForCity: iCity) { (iSucceed) in
            iCompletionBlock(iSucceed)
        }
    }
    
    private func fetchWeatherInformation(ForCity iCity: String, andCompletionBlock iCompletionBlock: @escaping ((_ iSucceed: Bool) -> ())) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(iCity.replacingOccurrences(of: " ", with: "%20"))&appid=4cbb3c4f49e2b6722b7026dace4fdc98"
        let theURL = URL.init(string: urlString)
        
        RequestBuilder.sendRequest(withURL: theURL!, requestType: .POST) { (iSucceed, iData, iURLResponse) in
            if iSucceed {
                DispatchQueue.main.async {
                    let theParsedResponse = ResponseParser.parseResponse(iData: iData as! Data)
                    DataManager.processCityData(withDetails: theParsedResponse, andCompletionBlock: { (iSucceed) in
                        if iSucceed == true {
                            iCompletionBlock(true)
                        } else {
                            iCompletionBlock(false)
                        }
                    })
                }
            } else {
                iCompletionBlock(false)
            }
        }
    }
}
