//
//  Photo.swift
//  Photorama
//
//  Created by Roman Ustiantcev on 30/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit
import CoreData


class Photo: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    var image : UIImage?
    
    override func awakeFromInsert() {
        title = ""
        photoID = ""
        remoteURL = NSURL()
        photoKey = NSUUID().UUIDString
        dateTaken = NSDate
    }

}
