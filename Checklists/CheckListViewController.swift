//
//  ViewController.swift
//  Checklists
//
//  Created by gecko on 10/03/15.
//  Copyright (c) 2015 StelarTechnology. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    
    var items: [ChecklistItem]
    
    required init(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        
        
        let row0item = ChecklistItem(); row0item.text = "Walk the dog"; row0item.checked = false; items.append(row0item)
        let row1item = ChecklistItem(); row1item.text = "Brush my teeth"; row1item.checked = true; items.append(row1item)
        let row2item = ChecklistItem(); row2item.text = "Learn iOS development"; row2item.checked = true ;items.append(row2item)
        let row3item = ChecklistItem(); row3item.text = "Soccer practice"; row3item.checked = false; items.append(row3item)
        let row4item = ChecklistItem(); row4item.text = "Eat ice cream"; row4item.checked = true; items.append(row4item)
        
        
        
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureTextForCell(cell: UITableViewCell, withCheckListItem item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as UILabel
        
        label.text = item.text
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell,
        withCheckListItem item: ChecklistItem) {
            
            if item.checked {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
    }
    
    
    // Data source
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("CheckListItem") as UITableViewCell
            
        let item = items[indexPath.row]
        
        configureTextForCell(cell, withCheckListItem: item)
        configureCheckmarkForCell(cell, withCheckListItem: item)
            
        return cell
    }
    
    // Delegate
    override func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
           let item = items[indexPath.row]
            item.toggleChecked()
        
            configureCheckmarkForCell(cell, withCheckListItem: item)
        
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

