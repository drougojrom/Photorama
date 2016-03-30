//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by Roman Ustiantcev on 30/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImageForPhoto(photo) { (result) -> Void in
            switch result {
            case let .Success(image):
                NSOperationQueue.mainQueue().addOperationWithBlock(){
                    self.imageView.image = image
                }
            case let .Failure(error):
                    print("Error fetching image \(error)")
                }
            }
    }



}

