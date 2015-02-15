//
//  FirstViewController.swift
//  Cogsy
//
//  Created by Tyler Kirane on 2/10/15.
//  Copyright (c) 2015 enarik. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    var oRLogItems = [OwnedRecordsNS]()
    
    var cell : UITableViewCell?

    
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
        
        // Now that the view loaded, we have a frame for the view, which will be (0,0,screen width, screen height)
        // This is a good size for the table view as well, so let's use that
        // The only adjust we'll make is to move it down by 20 pixels, and reduce the size by 20 pixels
        // in order to account for the status bar
        
        // Store the full frame in a temporary variable
        var viewFrame = self.view.frame
        
        // Adjust it down by 20 points
        viewFrame.origin.y += 20
        
        // Add in the "+" button at the bottom
        let addButton = UIButton(frame: CGRectMake(0, UIScreen.mainScreen().bounds.size.height - 93, UIScreen.mainScreen().bounds.size.width, 44))
        addButton.setTitle("+", forState: .Normal)
        addButton.backgroundColor = UIColor(red: 0.5, green: 0.9, blue: 0.5, alpha: 1.0)
        addButton.addTarget(self, action: "addNewItem", forControlEvents: .TouchUpInside)
        self.view.addSubview(addButton)
        
        // Reduce the total height by 20 points for the status bar, and 44 points for the bottom button
        viewFrame.size.height -= (93 + addButton.frame.size.height)
        
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
        
        // This tells the table view that it should get it's data from this class, ViewController
        oRTableView.dataSource = self
        oRTableView.delegate = self
        
                fetchLog()
        }
        
        func fetchLog() {
            let fetchRequest = NSFetchRequest(entityName: "OwnedRecordsNS")
            
            // Create a sort descriptor object that sorts on the "title"
            // property of the Core Data object
            let sortDescriptor = NSSortDescriptor(key: "artist", ascending: true)
            
            // Set the list of sort descriptors in the fetch request,
            // so it includes the sort descriptor
            fetchRequest.sortDescriptors = [sortDescriptor]
            
            if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [OwnedRecordsNS] {
                oRLogItems = fetchResults
            }
        }
    
    func presentItemInfo() {
        let fetchRequest = NSFetchRequest(entityName: "OwnedRecordsNS")
        if let fetchResults = managedObjectContext!.executeFetchRequest(fetchRequest, error: nil) as? [OwnedRecordsNS] {
            
            let alert = UIAlertController(title: fetchResults[0].artist,
                message: fetchResults[0].album,
                preferredStyle: .Alert)
            
            self.presentViewController(alert,
                animated: true,
                completion: nil)
        }
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == .Delete ) {
            // Find the LogItem object the user is trying to delete
            let logItemToDelete = oRLogItems[indexPath.row]
            
            // Delete it from the managedObjectContext
            managedObjectContext?.deleteObject(logItemToDelete)
            
            // Refresh the table view to indicate that it's deleted
            self.fetchLog()
            
            // Tell the table view to animate out that row
            oRTableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            save()
        }
    }
    
    
    
    let addItemAlertViewTag = 0
    let addItemTextAlertViewTag = 1
    func addNewItem() {
        
        var titlePrompt = UIAlertController(title: "Enter Artist",
            message: "Enter Text",
            preferredStyle: .Alert)
        
        var titleTextField: UITextField?
        titlePrompt.addTextFieldWithConfigurationHandler {
            (textField) -> Void in
            titleTextField = textField
            textField.placeholder = "Title"
        }
        
        titlePrompt.addAction(UIAlertAction(title: "Ok",
            style: .Default,
            handler: { (action) -> Void in
                if let textField = titleTextField {
                    self.saveNewItem(textField.text)
                }
        }))
        
        self.presentViewController(titlePrompt,
            animated: true,
            completion: nil)
    }
    
    func saveNewItem(title : String) {
        // Create the new  log item
        var newLogItem = OwnedRecordsNS.createInManagedObjectContext(self.managedObjectContext!, artist: title, album: "")
        
        // Update the array containing the table view row data
        self.fetchLog()
        
        // Animate in the new row
        // Use Swift's find() function to figure out the index of the newLogItem
        // after it's been added and sorted in our logItems array
        if let newItemIndex = find(oRLogItems, newLogItem) {
            // Create an NSIndexPath from the newItemIndex
            let newLogItemIndexPath = NSIndexPath(forRow: newItemIndex, inSection: 0)
            // Animate in the insertion of this row
            oRTableView.insertRowsAtIndexPaths([ newLogItemIndexPath ], withRowAnimation: .Automatic)
            save()
        }
    }
    
    func save() {
        var error : NSError?
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
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
        return oRLogItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LogCell") as UITableViewCell
        
        // Get the LogItem for this index
        let logItem = oRLogItems[indexPath.row]
        
        // Set the title of the cell to be the title of the logItem
        cell.textLabel?.text = logItem.artist
        return cell
    }
    
    
    
    // MARK: UITableViewDelegate
    func oRtableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let logItem = oRLogItems[indexPath.row]
        println(logItem.album)
    }
    
}
