//
//  FirstViewController.swift
//  Cogsy
//
//  Created by Tyler Kirane on 2/10/15.
//  Copyright (c) 2015 enarik. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var ownedTableView: UITableView!
    
    var ownedRecords = [String]()
    
    @IBAction func addOwnedRecord(sender: AnyObject) {
        var alert = UIAlertController(title: "Record",
            message: "Add a record you own",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let textField = alert.textFields![0] as UITextField
                self.ownedRecords.append(textField.text)
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
            return ownedRecords.count
    }
    
    func tableView(ownedTableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            ownedTableView.dequeueReusableCellWithIdentifier("Cell")
                as UITableViewCell
            
            cell.textLabel!.text = ownedRecords[indexPath.row]
            
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

