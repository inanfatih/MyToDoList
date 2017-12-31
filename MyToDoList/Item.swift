//
//  Item.swift
//  MyToDoList
//
//  Created by Fatih inan on 12/31/17.
//  Copyright © 2017 Fatih inan. All rights reserved.
//

import UIKit

class Item {
    var title: String
    var description: String?
    var isCompleted: Bool = false
    
    init(title providedTitle: String, description providedDescription: String?) {
        title = providedTitle
        description = providedDescription
    }
    
}

extension Item
{
    public class func getMockData() -> [Item]
    {
        return [
            Item(title: "first todo", description: "todo description")
            
        ]
    }
}

