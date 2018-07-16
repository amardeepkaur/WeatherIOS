//
//  ResponseParser.swift
//  ByteMark
//
//  Created by Amardeep on 13/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//

import UIKit

class ResponseParser: NSObject {
    class func parseResponse(iData: Data) -> [AnyHashable: Any] {
        var theResponse: [AnyHashable: Any]? = [AnyHashable: Any]()
        do {
            theResponse = try JSONSerialization.jsonObject(with: iData, options: .allowFragments) as? [AnyHashable: Any]
        } catch  {
            
        }
        return theResponse!
    }
}
