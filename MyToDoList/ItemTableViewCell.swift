//
//  ItemTableViewCell.swift
//  MyToDoList
//
//  Created by Mehmet Fatih inan & Kamalpreet Singh on 12/31/17.
//  Copyright © 2017 Mehmet Fatih inan  & Kamalpreet Singh. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    var onClick: ( (ItemTableViewCell) -> () )?
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var toSwitch: UISwitch!
    @IBAction func doneSwitch(_ sender: UISwitch) {
        
               onClick?(self)

    }
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

