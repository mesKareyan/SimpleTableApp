//
//  File.swift
//  SimpleListView
//
//  Created by Mesrop Kareyan on 10/20/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import Foundation

struct Category {
    
    let colorHex: String
    let icon: String
    let id: String
    let name: String
    let order: String
    
    init?(dict: Dictionary<String, Any>) {
        guard let colorHex = dict["color"]  as? String,
         let icon     = dict["icon"]   as? String,
         let id       = dict["id"]     as? String,
         let name     = dict["name"]   as? String,
         let order    = dict["order"]  as? String
        else  {
                return nil
        }
        self.colorHex = colorHex
        self.icon = icon
        self.id = id
        self.name = name
        self.order = order
    }
    
}
