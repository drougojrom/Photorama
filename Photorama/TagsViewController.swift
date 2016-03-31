//
//  TagsViewController.swift
//  Photorama
//
//  Created by Roman Ustiantcev on 31/03/16.
//  Copyright © 2016 Roman Ustiantcev. All rights reserved.
//

import UIKit
import CoreData

class TagsViewController : UITableViewController {

    var store: PhotoStore!
    var photo: Photo!
    
    var selectedIndexPath = [NSIndexPath]()
    
    let tagDataSource = TagDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = tagDataSource
        tableView.delegate = self
        updateTags()
    }
    
    func updateTags(){
        let tags = try! store.fetchMainQueueTags(predicate: nil, sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
        tagDataSource.tags = tags
        
        for tag in photo.tags {
            if let index = tagDataSource.tags.indexOf(tag) {
                let indexPath = NSIndexPath(forRow: index, inSection: 0)
                selectedIndexPath.append(indexPath)
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let tag = tagDataSource.tags[indexPath.row]
        
        if let index = selectedIndexPath.indexOf(indexPath) {
            selectedIndexPath.removeAtIndex(index)
            photo.removeTagObject(tag)
        } else {
            selectedIndexPath.append(indexPath)
            photo.addTagObject(tag)
        }
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        do {
            try store.coreDataStack.saveChanges()
        } catch let error {
            print("CoreData save failed \(error)")
        }
        
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if selectedIndexPath.indexOf(indexPath) != nil {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
    }
}
