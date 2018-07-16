//
//  RequestBuilder.swift
//  ByteMark
//
//  Created by Amardeep on 13/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//

import UIKit

enum RequestType: String {
    case GET = "Get"
    case POST = "Post"
    case PUT = "Put"
    case DELETE = "Delete"
}

class RequestBuilder: NSObject {
    class func sendRequest(withURL iURL: URL, requestType iRequestType: RequestType, andCompletionBlock iCompletionBlock:@escaping ((_ iSucceed: Bool, _ iData: Any, _ iResponse: URLResponse) -> ())) {
        // Create a url request
        var theURLRequest: URLRequest = URLRequest.init(url: iURL)
        theURLRequest.httpMethod = iRequestType.rawValue
        
        // Create a session configuration
        let theSessionConfiguration = URLSessionConfiguration.default
        
        // Create the session
        let theSession = URLSession.init(configuration: theSessionConfiguration)
        
        // Create the session task
//        let theSessionTask = theSession.dataTask(with: theURLRequest) { (iData, iURLResponse, iError) in
//            if iError != nil {
//                if let errorValue = iError, let urlResponseValue = iURLResponse {
//                    iCompletionBlock(false, errorValue, urlResponseValue)
//                }
//            } else {
//                if let dataValue = iData, let urlResponseValue = iURLResponse {
//                    iCompletionBlock(true, dataValue, urlResponseValue)
//                }
//            }
//        }
//        theSessionTask.resume()
        
        // Create the session task
        let  theSessionTask = theSession.dataTask(with: iURL) { (iData, iURLResponse, iError) in
            if iError != nil {
                if let errorValue = iError, let urlResponseValue = iURLResponse {
                    iCompletionBlock(false, errorValue, urlResponseValue)
                }
            } else {
                if let dataValue = iData, let urlResponseValue = iURLResponse {
                    iCompletionBlock(true, dataValue, urlResponseValue)
                }
            }
        }
        
        theSessionTask.resume()
    }
}
