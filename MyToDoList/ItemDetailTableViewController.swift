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
    
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            self.title = "Edit Item"
            itemNameTextField.text = item.title
            itemDescriptionTextField.text = item.description
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
            
            item = Item(title: name, description: description)
        }
    }
}
