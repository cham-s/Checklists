//
//  ViewController.swift
//  Checklists
//
//  Created by gecko on 10/03/15.
//  Copyright (c) 2015 StelarTechnology. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, AddItemViewControllerDelegate {
    
    // MARK: Object Properties
    var items: [ChecklistItem]
    
    required init(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        super.init(coder: aDecoder)
        loadChecklistItems()
    }
    
    // MARK: Overwritten Object Methods
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
            
            let label = cell.viewWithTag(1001) as UILabel
            
            if item.checked {
                label.text = "√"
            } else {
                label.text = ""
            }
    }
    
    
    // MARK: TableView Data Source
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
    
    // MARK: TableView Delegate Methods
    override func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
           let item = items[indexPath.row]
            item.toggleChecked()
        
            configureCheckmarkForCell(cell, withCheckListItem: item)
            
            saveChecklistItems()
        
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            items.removeAtIndex(indexPath.row)
            
            let indexPaths = [indexPath]
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        saveChecklistItems()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "AddItem" {
            
            let navigationController = segue.destinationViewController as UINavigationController
            
            let controller = navigationController.topViewController as ItemDetailViewController
            
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destinationViewController as UINavigationController
            
            let controller = navigationController.topViewController as ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
    
    
    // MARK: AddItem delegate
    func addItemViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishedEditing item: ChecklistItem) {
        if let index = find(items, item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withCheckListItem: item)
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
        saveChecklistItems()
    }
    
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishedAddingItem item: ChecklistItem) {
        
        let newRowIndex = items.count
        
        items.append(item)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        
        dismissViewControllerAnimated(true, completion: nil)
        saveChecklistItems()
    }
    
    // MARK: Data Section
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("Checklists.plist")
    }
    
    func saveChecklistItems() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(items, forKey: "ChecklistItems")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChecklistItems() {
        let path = dataFilePath()
        
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                
                items = unarchiver.decodeObjectForKey("ChecklistItems") as [ChecklistItem]
                
                unarchiver.finishDecoding()
            }
        }
    }
}
































