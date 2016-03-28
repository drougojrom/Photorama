//
//  FlickrAPI.swift
//  Photorama
//
//  Created by Roman Ustiantcev on 28/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Foundation

enum Method: String {
    case RecentPhotos = "flickr.photos.getRecent"
}

struct FlickrAPI {
    
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "073a626094e442c586d1642e7ed079c5"
    
    private static func flickrURL(method method: Method,
                                  parameters: [String:String]?) -> NSURL {
        
        let components = NSURLComponents(string: baseURLString)!
        var queryItems = [NSURLQueryItem]()
        
       let baseParams = [
            "method" : method.rawValue,
            "format" : "json",
            "nojsoncallback" : "1",
            "api_key" : APIKey
        ]
        
        for (key, value) in baseParams {
            let item = NSURLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = NSURLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        
        components.queryItems = queryItems
        return components.URL!
        
    }
    
    static func recentPhotosURL() -> NSURL {
        return flickrURL(method: .RecentPhotos,
                         parameters: ["extras": "url_h"])
    }
    
}