//
//  Photo.swift
//  Photorama
//
//  Created by Roman Ustiantcev on 28/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import Foundation

class Photo {
    
    let title: String
    let remoteURL: NSURL
    let photoID: String
    let dateTaken: NSDate
    
    init(title: String, photoID: String, remoteURL: NSURL, dateTaken: NSDate){
        self.title = title
        self.photoID = photoID
        self.remoteURL = remoteURL
        self.dateTaken = dateTaken
    }
    
    
}