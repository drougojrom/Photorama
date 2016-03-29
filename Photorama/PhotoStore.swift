//
//  PhotoStore.swift
//  Photorama
//
//  Created by Roman Ustiantcev on 28/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

enum ImageResult {
    case Success(UIImage)
    case Failure(ErrorType)
}

enum PhotoError: ErrorType {
    case ImageCreationEror
}

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
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print("Status code: \(httpResponse.statusCode)" )
                print("headerFields: \(httpResponse.allHeaderFields)")
            }
            
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
    
    func fetchImageForPhoto(photo: Photo, completion: (ImageResult) -> Void) {
        let photoURL = photo.remoteURL
        let request = NSURLRequest(URL: photoURL)
        
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            
            let result = self.processImageRequest(data: data, error: error)
            
            if case let .Success(image) = result {
                photo.image = image
            }
            
            completion(result)
        }
        task.resume()
    }
    
    func processImageRequest(data data: NSData?, error: NSError?) -> ImageResult {
        guard let imageData = data, image = UIImage(data: imageData) else {
            // couldnt create an image
            if data == nil {
                return .Failure(error!)
            } else {
                return .Failure(PhotoError.ImageCreationEror)
            }
        }
        
        return .Success(image)
    }
    
    
    
}