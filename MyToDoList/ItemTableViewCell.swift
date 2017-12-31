//
//  ItemTableViewCell.swift
//  MyToDoList
//
//  Created by Fatih inan on 12/31/17.
//  Copyright © 2017 Fatih inan. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    var onClick: ( (ItemTableViewCell) -> () )?
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        
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

