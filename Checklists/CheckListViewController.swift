//
//  ViewController.swift
//  Checklists
//
//  Created by gecko on 10/03/15.
//  Copyright (c) 2015 StelarTechnology. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("CheckListItem") as UITableViewCell
        
        let label = cell.viewWithTag(1000) as UILabel
        
        if indexPath.row % 5 == 0 {
            label.text = "Walk the dog"
        } else if indexPath.row % 5 == 1 {
            label.text = "Brush my teeth"
        } else if indexPath.row % 5 == 2 {
            label.text = "Learn iOS development"
        } else if indexPath.row % 5 == 3 {
            label.text = "Soccer Practice"
        } else if indexPath.row % 5 == 4 {
            label.text = "Eat Ice cream"
        } 
        
        return cell
    }
    
    // Delegate
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .None {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

