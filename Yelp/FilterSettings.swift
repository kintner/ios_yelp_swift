//
//  FilterSetting.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

class FilterSettings {
    var category : String?
    var sort : sortKeys?
    var hasDeals: Boolean?
    
    enum sortKeys { case bestMatch, distance, rating }
    
    init() {
        
    }
    
}