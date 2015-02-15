//
//  FirstViewController.swift
//  Cogsy
//
//  Created by Tyler Kirane on 2/10/15.
//  Copyright (c) 2015 enarik. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var managedObjectContext : NSManagedObjectContext? = {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        if let managedObjectContext = appDelegate.managedObjectContext {
            return managedObjectContext
        }
        else {
            return nil
        }
        }()
    
    // Create the table view as soon as this class loads
    var oRTableView = UITableView(frame: CGRectZero, style: .Plain)
    
    
    // Create an empty array of LogItem's
    var ownedRecordsLog = [OwnedRecordsNS]()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let moc = self.managedObjectContext {
            
            OwnedRecordsNS.createInManagedObjectContext(moc,
                artist: "1st Item",
                album: "This is my first log item")
            
            OwnedRecordsNS.createInManagedObjectContext(moc,
                artist: "2nd Item",
                album: "This is my second log item")
            
            OwnedRecordsNS.createInManagedObjectContext(moc,
                artist: "3rd Item",
                album: "This is my third log item")
            
            OwnedRecordsNS.createInManagedObjectContext(moc,
                artist: "4th Item",
                album: "This is my fourth log item")
            
            OwnedRecordsNS.createInManagedObjectContext(moc,
                artist: "5th Item",
                album: "This is my fifth log item")
            
            OwnedRecordsNS.createInManagedObjectContext(moc,
                artist: "6th Item",
                album: "This is my sixth log item")
            
        }
        
        // This tells the table view that it should get it's data from this class, ViewController
        oRTableView.dataSource = self
        oRTableView.delegate = self
        
        // Now that the view loaded, we have a frame for the view, which will be (0,0,screen width, screen height)
        // This is a good size for the table view as well, so let's use that
        // The only adjust we'll make is to move it down by 20 pixels, and reduce the size by 20 pixels
        // in order to account for the status bar
        
        // Store the full frame in a temporary variable
        var viewFrame = self.view.frame
        
        // Adjust it down by 20 points
        viewFrame.origin.y += 20
        
        // Reduce the total height by 20 points
        viewFrame.size.height -= 20
        
        // Set the logTableview's frame to equal our temporary variable with the full size of the view
        // adjusted to account for the status bar height
        oRTableView.frame = viewFrame
        
        // Add the table view to this view controller's view
        self.view.addSubview(oRTableView)
        
        // Here, we tell the table view that we intend to use a cell we're going to call "LogCell"
        // This will be associated with the standard UITableViewCell class for now
        oRTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "LogCell")
        
        // This tells the table view that it should get it's data from this class, ViewController
        oRTableView.dataSource = self
        
        fetchLog()
    }
    
    func fetchLog() {
        let fetchRequest = NSFetchRequest(entityName: "OwnedRecordsNS")
        
        // Create a sort descriptor object that sorts on the "title"
        // property of the Core Data object
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        
        // Set the list of sort descriptors in the fetch request,
        // so it includes the sort descriptor
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [OwnedRecordsNS] {
            ownedRecordsLog = fetchResults
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // How many rows are there in this section?
        // There's only 1 section, and it has a number of rows
        // equal to the number of logItems, so return the count
        return ownedRecordsLog.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LogCell") as UITableViewCell
        
        // Get the LogItem for this index
        let logItem = ownedRecordsLog[indexPath.row]
        
        // Set the title of the cell to be the title of the logItem
        cell.textLabel?.text = logItem.artist
        return cell
    }

    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let logItem = ownedRecordsLog[indexPath.row]
        println(logItem.artist)
    }


}
