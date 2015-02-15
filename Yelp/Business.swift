//
//  Business.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/10/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//


class Business {
    var name : String?
    var imageUrl : NSURL?
    var ratingImageUrl : NSURL?
    var numRatings: Int?
    var address : String?
    var categories : String?
    var distance : Double?
  
    
    init(fromDictionary dictionary: NSDictionary) {
        NSLog("dict: %@", dictionary)
        
        if let cats = dictionary.valueForKeyPath("categories") as? [[String]] {
            categories = ", ".join(cats.map({$0[0]}))
        }
        
        name = dictionary.valueForKeyPath("name") as? String
        
        if let url = dictionary.valueForKeyPath("image_url") as String? {
           imageUrl = NSURL(string: url)
        }
        
        
        var street = dictionary.valueForKeyPath("location.address") as? [String]
        var neighborhood = dictionary.valueForKeyPath("location.neighborhoods") as? [String]
        
        if let s = street {
            if s.count > 0 {
                if let n = neighborhood {
                    if s.count > 0 {
                        address = "\(s[0]) \(n[0])"
                    }
                } else {
                    address = "\(s[0])"
                }
            }
        }
        
        numRatings = dictionary.valueForKeyPath("review_count") as? Int
        ratingImageUrl = NSURL(string: dictionary.valueForKeyPath("rating_img_url") as String)
        
        var milesPerMeter = 0.000621371
        
        distance = (dictionary.valueForKeyPath("distance") as Double) * milesPerMeter
    }
    
    class func businessesWithDictionaries(dictionaries : [NSDictionary]) -> [Business] {
        return dictionaries.map({ Business(fromDictionary: $0) })
    }
   
}
