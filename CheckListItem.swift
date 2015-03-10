//
//  CheckListItem.swift
//  Checklists
//
//  Created by gecko on 10/03/15.
//  Copyright (c) 2015 StelarTechnology. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
