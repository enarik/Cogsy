//
//  CraigslistViewController.swift
//  Cogsy
//
//  Created by Tyler Kirane on 2/10/15.
//  Copyright (c) 2015 enarik. All rights reserved.
//

import UIKit

class CraigslistViewController: UIViewController {
    
    @IBOutlet weak var clView: CLWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestURL = NSURL(string: "http://craigslist.org")
        let request = NSURLRequest(URL: requestURL!)
        clView.loadRequest(request)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}

    
    @IBAction func goBack(sender: AnyObject) {
    }
    
    
    @IBAction func goForward(sender: AnyObject) {
    }
    
    
    @IBAction func doRefresh(sender: AnyObject) {
    }
    
    @IBAction func stop(sender: AnyObject) {
    }

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
// Get the new view controller using segue.destinationViewController.
// Pass the selected object to the new view controller.
}
*/

}