//
//  ItemTableViewController.swift
//  MyToDoList
//
//  Created by Mehmet Fatih inan & Kamalpreet Singh on 12/31/17.
//  Copyright © 2017 Mehmet Fatih inan  & Kamalpreet Singh. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    private var items = Item.getMockData()
    
    @IBOutlet var tasksTableView: UITableView!
    var segmentItems: [Item]!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSegmentItems()
        self.title = "To Do List"
    }
    
    func getSegmentItems() {
        let items = self.items
        var allItems: [Item] = []
        for item in items {
            allItems.append(item)
        }
            segmentItems = allItems
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let segment = segmentItems else { return 0 }
        return segment.count
        
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        
        //load item
        let item = segmentItems[(indexPath as NSIndexPath).row]
        cell.itemNameLabel.text = item.title
        
        cell.onClick = { cell in
            
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            
            let item = self.segmentItems[indexPath.row]
            
            item.isCompleted = !item.isCompleted
            
            tableView.reloadData()
        }
        
        if item.isCompleted {
            cell.itemNameLabel.textColor = UIColor.gray
            cell.toSwitch.setOn(false, animated: true)
        } else {
            cell.toSwitch.setOn(true, animated: true)
            cell.itemNameLabel.textColor = UIColor.black
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        let item = segmentItems[row]
        displayItemDetails(item: item)
    }
    
    func displayItemDetails(item: Item) {
        performSegue(withIdentifier: "ToItemDetails", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            navigationItem.backBarButtonItem = backItem
        
        if let indexPath = tasksTableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            // Set destination view controller
            let detailVC = segue.destination as! ItemDetailTableViewController
            
            detailVC.item = items[selectedRow]
        }
        
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            
            items.remove(at: row)
            getSegmentItems()
            
            tableView.reloadData()
        } else if editingStyle == .insert {
        }
    }
    
    @IBAction func unwindToItemTable(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ItemDetailTableViewController, let item = sourceViewController.item {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                segmentItems[selectedIndexPath.row] = item
                
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                
                let count = items.count
                let newIndexPath = NSIndexPath(row: count, section: 0)
                print(newIndexPath.row)
                
                //add item to list
                items.append(item)
                
                getSegmentItems()
                
                tableView.reloadData()
            }
        }
    }
}

