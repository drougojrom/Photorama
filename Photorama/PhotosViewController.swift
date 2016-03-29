//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Roman Ustiantcev on 28/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchRecentPhotos() {
            (photosResult) -> Void in
            
            switch photosResult {
            case let .Success(photos):
                print("Successfully found \(photos.count) number of photos")
            case let .Failure(error):
                print("Error fetching revent photos \(error)")
            }
        }
    }
}
