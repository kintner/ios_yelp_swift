//
//  FilterKeyValue.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import Foundation

class FilterKeyValue {
    var name : String
    var value : String
    
    init(name: String, value: String) {
        self.name = name
        self.value = value
    }
}