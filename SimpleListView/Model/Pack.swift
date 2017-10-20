//
//  Pack.swift
//  SimpleListView
//
//  Created by Mesrop Kareyan on 10/20/17.
//  Copyright © 2017 mesrop. All rights reserved.
//

import Foundation

struct Pack {
    
    let icon: String
    let id: String
    let name: String
    let order: String
    var categoryID: String?
    var categoryName: String?
    
    init?(dict: Dictionary<String, Any>) {
        guard let icon     = dict["icon"]   as? String,
              let id       = dict["id"]     as? String,
              let name     = dict["name"]   as? String,
              let order    = dict["order"]  as? String
        else  {
                return nil
        }
        self.icon = icon
        self.id = id
        self.name = name
        self.order = order
    }
    
}
