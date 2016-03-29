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
    func fetchRecentPhotos(completion completion: (PhotosResult)-> Void) {
        let url = FlickrAPI.recentPhotosURL()
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            let result = self.processRecentPhotosRequest(data: data, error: error)
            completion(result)
            
        }
        task.resume()
    }
    
    // MARK : method process the JSON data into  PhotoResult
    
    func processRecentPhotosRequest(data data: NSData? , error: NSError?) -> PhotosResult {
        guard let jsonData = data else {
            return .Failure(error!)
        }
        
        return FlickrAPI.phorosFromJSONData(jsonData)
    }
    
    
    
    
    
    
}