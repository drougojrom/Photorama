//
//  PhotoStore.swift
//  Photorama
//
//  Created by Roman Ustiantcev on 28/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Foundation

class PhotoStore {
    
    let session: NSURLSession = {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        return NSURLSession(configuration: config)
    }()
    
    // MARK : function to ask for recent photos
    func fetchRecentPhotos(){
        let url = FlickrAPI.recentPhotosURL()
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            if let jsonData = data {
                do {
                    let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
                    print(jsonObject)
                }
                catch let error {
                    print("error creating object \(error)")
                }
            }
            
            else if let requestError = error {
                print("Error fetching recent photos with \(requestError)")
            } else {
                print("Unexpected error with request")
            }
        }
        task.resume()
    }
    
    
    
    
    
    
}