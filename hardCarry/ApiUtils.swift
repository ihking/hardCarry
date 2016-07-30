//
//  ApiUtils.swift
//  hardCarry
//
//  Created by HAN on 2016. 7. 30..
//  Copyright © 2016년 HAN. All rights reserved.
//

import UIKit
import Alamofire
import Foundation

class ApiUtils: NSObject {

    func testing() -> [String:String] {
        print("NICE SHOT!!!!")
        
        var pcbangInfo: [String:String] = [:]
        
        Alamofire.request(.GET, "http://52.78.17.139/api/parse/location?mapx=23.55&mapy=23323.55", parameters: ["foo": "bar"])
            .responseJSON { response in
                //print(response.request)  // original URL request
                //print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                switch response.result {
                case .Success(let JSON):
                    //print("Success with JSON: \(JSON)")
                    
                    let response = JSON as! NSDictionary
                    
                    if let locationData = response["locationData"] {
                        if let rss = locationData["rss"] {
                            let rss = rss as! NSDictionary
                            if let channel = rss["channel"] {
                                if let items = channel["item"] {
                                    for item in items as! NSArray {
                                        let telephone: String! = item["telephone"] as AnyObject? as? String
                                        let title: String! = item["title"] as AnyObject? as? String
                                        pcbangInfo.updateValue(telephone, forKey: title)
                                    }
                                }
                            }
                        }
                    }
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
        }
        return pcbangInfo
    }
}
