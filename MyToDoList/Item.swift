//
//  Item.swift
//  MyToDoList

//  Created by Mehmet Fatih inan & Kamalpreet Singh on 12/31/17.
//  Copyright © 2017 Mehmet Fatih inan  & Kamalpreet Singh. All rights reserved.
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
            Item(title: "sample todo", description: "todo description")
            
        ]
    }
}

