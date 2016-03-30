//
//  PhotosViewController.swift
//  Photorama
//
//  Created by Roman Ustiantcev on 28/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var store: PhotoStore!
    
    let photoDataSource = PhotoDataSource()
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let photo = photoDataSource.photos[indexPath.row]
        
        
        // download the image data, which could take some time
        store.fetchImageForPhoto(photo) {
            (result) -> Void in
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                // the index path for the photo might have changed between the time
                // the request started and finished, so find the most recent index path
                
                let photoIndex = self.photoDataSource.photos.indexOf(photo)!
                let photoIndexPath = NSIndexPath(forRow: photoIndex, inSection: 0)
                
                // when the request finishes update only visible cells
                
                if let cell = self.collectionView.cellForItemAtIndexPath(photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(photo.image)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = photoDataSource
        
        store.fetchRecentPhotos() {
            (photosResult) -> Void in
            
            NSOperationQueue.mainQueue().addOperationWithBlock() {
                switch photosResult{
                case let .Success(photos):
                    print("Sucessfully found photos \(photos.count)")
                    self.photoDataSource.photos = photos
                case let .Failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error) ")
                }
                self.collectionView.reloadSections(NSIndexSet(index: 0))
            }
        }
    }
}