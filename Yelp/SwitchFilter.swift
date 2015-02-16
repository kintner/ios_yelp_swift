//
//  SwitchFilter.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation

class SwitchFilter : Filter {
    
    override func toggleOption(optionIndex: Int) -> Bool {
        if selectedIndicies.isEmpty {
            selectedIndicies.append(optionIndex)
            return true
        } else {
            selectedIndicies.removeAtIndex(optionIndex)
            return false
        }
    }
    
    override func optionSelected(index: Int) -> Bool {
        return !selectedIndicies.isEmpty
    }
    
    override func selectedValues() -> String {
        return selectedIndicies.isEmpty ? "false" : "true"
    }
    
}