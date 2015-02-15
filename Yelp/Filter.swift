//
//  Filters.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

class Filter {
    let displayName: String
    let type : filterType
    var values : [FilterKeyValue]
    var selectedIndicies : [Int]
    var allowsMultipleSelection = false
    
    
    enum filterType { case list, boolean }
    
    init(displayName: String, type: filterType) {
        self.displayName = displayName
        self.type = type
        self.selectedIndicies = []
        self.values = []
    }
    
//    func selectValue(value: String) {
//        var tuple = findValueForName(value)
//        if (!tuple) {
//            selectedValues.append(
//            
//        }
//    }
//    
//    func selectedValue(name: String) -> Bool {
//        return findValueForName(name) != nil
//    }
//    
//    func findValueForName(name: String) -> FilterKeyValue? {
//        selectedValues.filter({ $0.name == name})
//    }
    
    
    func optionSelected(index: Int) -> Bool {
        return contains(selectedIndicies, index)
    }
    
    func toggleOption(optionIndex : Int) -> Bool {
        var index = find(selectedIndicies, optionIndex)
        if index != nil {
            selectedIndicies.removeAtIndex(index!)
            return false
        } else {
            if !allowsMultipleSelection {
                selectedIndicies.removeAll(keepCapacity: true)
            }
                        
            selectedIndicies.append(optionIndex)
            return true
        }
    }
    
    class func defaultFilters() -> [Filter] {
        let filters = []
        
        var sortFilter = Filter(displayName: "Sort By", type: filterType.list)
        sortFilter.values.append(FilterKeyValue(name: "Best Matched", value: "0"))
        sortFilter.values.append(FilterKeyValue(name: "Distance", value: "1"))
        sortFilter.values.append(FilterKeyValue(name: "Highest Rated", value: "2"))
        
        return [sortFilter]
        
    }
    
}

//Filter(label: "Best Matched", value: "0", selected: true),
//Filter(label: "Distance", value: "1"),
//Filter(label: "Highest Rated", value: "2")