//
//  FirstViewController.swift
//  Cogsy
//
//  Created by Tyler Kirane on 2/10/15.
//  Copyright (c) 2015 enarik. All rights reserved.
//

import UIKit
import CoreData

class FirstViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var ownedTableView: UITableView!
    
    var ownedRecordsArray = [NSManagedObject]()
    
    @IBAction func addOwnedRecord(sender: AnyObject) {
        var alert = UIAlertController(title: "Record",
            message: "Add a record you own",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let textField = alert.textFields![0] as UITextField
                self.addOwnedRecord(textField.text)
                self.ownedTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Owned Records"
        ownedTableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
    }

    // MARK: UITableViewDataSource
    func tableView(ownedTableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return ownedRecordsArray.count
    }
    
    func tableView(ownedTableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            ownedTableView.dequeueReusableCellWithIdentifier("Cell")
                as UITableViewCell
            
            let OwnedRecords = ownedRecordsArray[indexPath.row]
            cell.textLabel!.text = OwnedRecords.valueForKey("name") as String?
            
            return cell
    }

    
    
    func saveName(name: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("OwnedRecords",
            inManagedObjectContext:
            managedContext)
        
        let ownedRecords = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        ownedRecords.setValue(name, forKey: "name")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }  
        //5
        ownedRecordsArray.append(ownedRecords)
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"OwnedRecords")
        
        //3
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            ownedRecordsArray = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    

}

