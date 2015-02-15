//
//  FilterSetting.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

class FilterSettings {
    var categories : [String]
    var sort : sortKeys
    var hasDeals: Bool
    
    enum sortKeys { case bestMatch, distance, rating }
    
    init() {
        categories = []
        sort = sortKeys.distance
        hasDeals = false
    }
    
}