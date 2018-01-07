//
//  ItemDetailTableViewController.swift
//  MyToDoList
//
//  Created by Mehmet Fatih inan & Kamalpreet Singh on 12/31/17.
//  Copyright © 2017 Mehmet Fatih inan  & Kamalpreet Singh. All rights reserved.
//

import UIKit

class ItemDetailTableViewController: UITableViewController {
    
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemDescriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
    
        if(presentingViewController != nil){
            dismiss(animated: true, completion: nil)
        }
        
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true);
        }
    }
    
    var item:NSDictionary = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if item["id"] != nil {
            self.title = "Edit Item"
            itemNameTextField.text = (item.value(forKey: "title") as! String)
            itemDescriptionTextField.text = (item.value(forKey: "desc") as! String)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if saveButton === sender as? UIBarButtonItem {
            
            guard let name = itemNameTextField.text else { return true }
            
            if (name.isEmpty) {
                let alertController = UIAlertController(title: "Enter Item Name", message:
                    "You must enter an item name", preferredStyle: UIAlertControllerStyle.alert)
                
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)

                return false
                
            } else {
                return true
            }
        }
        return true
    }
    
    // send back to previous view // using exit and unwindToView
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if saveButton === sender as? UIBarButtonItem {
            
            let name = itemNameTextField.text ?? ""
            let description = itemDescriptionTextField.text ?? ""
            /*
            item = Item(title: name, description: description)
            */
 
            // Creating Dictionary
            var dataSet:NSMutableDictionary = NSMutableDictionary()
            dataSet.setValue(name, forKey: "title")
            dataSet.setValue(description, forKey: "desc")
            dataSet.setValue(false, forKey: "completed")
            dataSet.setValue(UUID().uuidString, forKey: "id")
            
            // Accessing UserDefaults
            
            //var userDefaults = UserDefaults.standard
            //var itemList:NSMutableArray? = userDefaults.object(forKey: "itemList") as? NSMutableArray
            
            var itemList:NSMutableArray? = NSMutableArray()
            var userDefaults = UserDefaults.standard
            
            if let ud = userDefaults.object(forKey: "itemList") as? NSArray {
                itemList = ud.mutableCopy() as! NSMutableArray
            }
            
            let tableVC = segue.destination as! ItemTableViewController
            
            if itemList!.count > 0 { // data available
                
                var newMutuableList:NSMutableArray = NSMutableArray()
                
                for dict in itemList! {
                    
                    if(item["id"] != nil) {
                        
                        var _dict = (dict as! NSDictionary).mutableCopy() as! NSMutableDictionary
                        
                        if (_dict.value(forKey: "id") as! String == item.value(forKey: "id") as! String) {
                            _dict.setValue(name, forKey: "title")
                            _dict.setValue(description, forKey: "desc")
                        }
                        
                        newMutuableList.add(_dict)
                        
                    } else {
                        newMutuableList.add(dict as! NSDictionary)
                    }
                }
                
                userDefaults.removeObject(forKey: "itemList")
                
                if(item["id"] == nil) {
                    newMutuableList.add(dataSet)
                }
                
                userDefaults.set(newMutuableList, forKey: "itemList")
                
                tableVC.todoItems = newMutuableList
                
            } else { // First Item in To do list
                userDefaults.removeObject(forKey: "itemList")
                
                itemList = NSMutableArray()
                itemList!.add(dataSet)
                
                userDefaults.set(itemList, forKey: "itemList")
                
                tableVC.todoItems = itemList!
            }
            
            userDefaults.synchronize()
        }
    }
}
