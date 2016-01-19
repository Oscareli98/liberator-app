//
//  NavigationTableViewController.swift
//  Liberator
//
//  Created by Oscar Newman on 9/13/14.
//  Copyright (c) 2014 Oscar Newman. All rights reserved.
//

import UIKit

class NavigationTableViewController: UITableViewController {
    
    let photoOfDayURL = "http://instagram.com/lbjliberator"
    
    let items       = ["Top Stories", "Photo of the Day", "News", "Commentary", "Feature", "Entertainment", "Sports"]
    let categories  = ["", "", "news", "commentary", "feature", "entertainment", "sports"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        let rowToSelect:NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)  //slecting 0th row with 0th section
        self.tableView.selectRowAtIndexPath(rowToSelect, animated: true, scrollPosition: .None)
        
//        let rh = self.tableView.rowHeight
//        let cellsHeight = Int(rh) * items.count
//        let tvheight = Int(self.tableView.frame.size.height)
//        let offset = CGFloat((tvheight - cellsHeight) / 3)
//        
//        let header = UIView(frame: CGRectMake(0, 0, 1, offset))
//        self.tableView.tableHeaderView = header

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == find(items, "Photo of the Day") {
            UIApplication.sharedApplication().openURL(NSURL(string: photoOfDayURL)!)
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell
        if items[indexPath.row] == "Photo of the Day" {
            cell = tableView.dequeueReusableCellWithIdentifier("linkCell") as UITableViewCell
        }
        else {
            cell = tableView.dequeueReusableCellWithIdentifier("categoryCell") as UITableViewCell
        }
        
        (cell.viewWithTag(1) as UILabel).text = items[indexPath.row]
        
        var highlight = UIView()
        highlight.backgroundColor = UIColor(white:0.157, alpha:1);
        cell.selectedBackgroundView = highlight
        
        
        return cell
    }
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.

        if segue.isKindOfClass(SWRevealViewControllerSeguePushController.classForCoder()) {
            var destinationViewController = (segue.destinationViewController as UINavigationController).viewControllers[0] as MasterViewController
            
            let selectedRow:NSIndexPath = self.tableView.indexPathForSelectedRow()!
            destinationViewController.category = categories[selectedRow.row]

        }
    }
    

}
