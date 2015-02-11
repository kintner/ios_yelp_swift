//
//  Business.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/10/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class Business {
    var name : String?
    var imageUrl : NSURL?
    var ratingImageUrl : NSURL?
    var numRatings: Int?
    var address : String?
    var categories : String?
    var distance : Double?
    
    
    init() {
        
    }
    
    init(fromDictionary dictionary: NSDictionary) {
        var cats = dictionary.valueForKeyPath("categories") as [[String]]
        categories = ", ".join(cats[0])
        
        name = dictionary.valueForKeyPath("name") as? String
        imageUrl = NSURL(string: dictionary.valueForKeyPath("image_url") as String)
        
        var street = dictionary.valueForKeyPath("location.address") as [String]
        var neighborhood = dictionary.valueForKeyPath("location.neighborhoods") as [String]
        address = "\(street[0]) \(neighborhood[0])"
        
        numRatings = dictionary.valueForKeyPath("review_count") as? Int
        ratingImageUrl = NSURL(string: dictionary.valueForKeyPath("rating_img_url") as String)
        
        var milesPerMeter = 0.000621371
        
        distance = 3.141 //(dictionary.valueForKeyPath("distance") as Double) * milesPerMeter
    }
    
    class func businessesWithDictionaries(dictionaries : [NSDictionary]) -> [Business] {
        return dictionaries.map({ Business(fromDictionary: $0) })
    }
   
}
