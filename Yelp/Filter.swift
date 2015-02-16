//
//  Filters.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

class Filter:NSObject {
    let name : String
    let sectionName: String
    let type : filterType
    var values : [FilterKeyValue]
    var selectedIndicies : [Int]
    var allowsMultipleSelection = false
    
    enum filterType { case list, boolean }
    
    init(name: String, sectionName: String, type: filterType) {
        self.name = name
        self.sectionName = sectionName
        self.type = type
        self.selectedIndicies = []
        self.values = []
    }
    
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
    
    func selectedValues() -> String {
        return  ",".join(selectedIndicies.map({self.values[$0].value}))
    }
    
    class func defaultFilters() -> [Filter] {
        var filters = [Filter]()
        
        var sortFilter = Filter(name: "sort", sectionName: "Sort By", type: filterType.list)
        sortFilter.values.append(FilterKeyValue(name: "Best Matched", value: "0"))
        sortFilter.values.append(FilterKeyValue(name: "Distance", value: "1"))
        sortFilter.values.append(FilterKeyValue(name: "Highest Rated", value: "2"))
        
        filters.append(sortFilter)
        
        var distanceFilter = Filter(name: "radius_filter", sectionName: "Distance", type: filterType.list)
        let metersPerMile = 1609.34
        var distances = [["5 miles", 5 * metersPerMile],
            ["10 miles", 10 * metersPerMile],
            ["15 miles", 15 * metersPerMile],
            ["25 miles", (5 * metersPerMile)]]
        
        for distance in distances {
            var meters = NSString(format: "%f", distance[1] as Double)
            distanceFilter.values.append(FilterKeyValue(name: distance[0] as String, value: meters))
        }
        
        filters.append(distanceFilter)
        
        
        var dealFilter = SwitchFilter(name: "deals_filter", sectionName: "Deals", type: filterType.boolean)
        dealFilter.values.append(FilterKeyValue(name: "Offering a Deal", value: "true"))
        filters.append(dealFilter)
        
        
        var categoryFilter = Filter(name: "category_filter", sectionName: "Categories", type:filterType.list)
        categoryFilter.allowsMultipleSelection = true
        categoryFilter.values = [
            FilterKeyValue(name: "American (New)", value: "newamerican"),
            FilterKeyValue(name: "American (Traditional)", value: "tradamerican"),
            FilterKeyValue(name: "Argentine", value: "argentine"),
            FilterKeyValue(name: "Breakfast & Brunch", value: "breakfast_brunch"),
            FilterKeyValue(name: "Burgers", value: "burgers"),
            FilterKeyValue(name: "Cafes", value: "cafes"),
            FilterKeyValue(name: "Chinese", value: "chinese"),
            FilterKeyValue(name: "Cuban", value: "cuban"),
            FilterKeyValue(name: "French", value: "french"),
            FilterKeyValue(name: "German", value: "german"),
            FilterKeyValue(name: "Greek", value: "greek"),
            FilterKeyValue(name: "Hawaiian", value: "hawaiian"),
            FilterKeyValue(name: "Indian", value: "indpak"),
            FilterKeyValue(name: "Irish", value: "irish"),
            FilterKeyValue(name: "Italian", value: "italian"),
            FilterKeyValue(name: "Japanese", value: "japanese"),
            FilterKeyValue(name: "Mediterranean", value: "mediterranean"),
            FilterKeyValue(name: "Mexican", value: "mexican"),
            FilterKeyValue(name: "Peruvian", value: "peruvian"),
            FilterKeyValue(name: "Pizza", value: "pizza"),
            FilterKeyValue(name: "Seafood", value: "seafood"),
            FilterKeyValue(name: "Spanish", value: "spanish"),
            FilterKeyValue(name: "Sushi Bars", value: "sushi"),
            FilterKeyValue(name: "Thai", value: "thai")
        ]
        
        filters.append(categoryFilter)
        
        
        return filters
        
    }
    
}
