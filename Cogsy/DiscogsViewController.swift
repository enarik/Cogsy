//
//  DiscogsViewController.swift
//  Cogsy
//
//  Created by Tyler Kirane on 2/10/15.
//  Copyright (c) 2015 enarik. All rights reserved.
//

import UIKit

class DiscogsViewController: UIViewController {

    
    @IBOutlet weak var discogsView: DiscogsButtonLink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let requestURL = NSURL(string: "http://discogs.com")
        let request = NSURLRequest(URL: requestURL!)
        discogsView.loadRequest(request)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func stop(sender: AnyObject) {
        DiscogsButtonLink.stopLoading(<#UIWebView#>)
    }
    
    @IBAction func doRefresh(sender: AnyObject) {
        DiscogsButtonLink.reload(<#UIWebView#>)
    }
    
    @IBAction func goBack(sender: AnyObject) {
        DiscogsButtonLink.goBack(<#UIWebView#>)
    }
    
    @IBAction func goForward(sender: AnyObject) {
        DiscogsButtonLink.goForward(<#UIWebView#>)
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