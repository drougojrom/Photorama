//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by Roman Ustiantcev on 29/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit


class PhotoDataSource: NSObject, UICollectionViewDataSource {
    
    var photos = [Photo]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let identifier = "UICollectionView"
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        
        return cell
        
    }
    
    
    
}