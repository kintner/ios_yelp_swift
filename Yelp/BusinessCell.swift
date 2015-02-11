//
//  BusinessCel.swift
//  Yelp
//
//  Created by Christopher Kintner on 2/10/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessCell: UITableViewCell {
    var model : Business?
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var numReviews: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!

    
    func updateFromModel(model : Business) {
        self.model = model
        self.title.text = model.name
        self.distance.text = "\(model.distance!) mi"
        self.cost.text = "TODO"
        self.numReviews.text = "\(model.numRatings!) Reviews"
        self.address.text = model.address
        self.categories.text = model.categories
        self.ratingImage.setImageWithURL(model.ratingImageUrl)
        self.posterImage.setImageWithURL(model.imageUrl)
        
        
        
    }

}
